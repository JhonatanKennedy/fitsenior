import Foundation

// MARK: - Modelos de Resposta do Supabase

struct SupabaseSession: Codable {
    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    let refreshToken: String
    let user: SupabaseUser
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case user
    }
}

struct SupabaseUser: Codable {
    let id: UUID
    let email: String?
    let phone: String?
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case phone
        case createdAt = "created_at"
    }
}

struct SupabaseAuthResponse: Codable {
    let session: SupabaseSession?
    let user: SupabaseUser?
}

// MARK: - Cliente Supabase Nativo

class SupabaseClient {
    static let shared = SupabaseClient()
    
    let baseURL: URL
    let apiKey: String
    let session = URLSession.shared
    
    // Armazenamento local para tokens
    let userDefaults = UserDefaults.standard
    let accessTokenKey = "supabase_access_token"
    let refreshTokenKey = "supabase_refresh_token"
    
    private init() {
        // IMPORTANTE: Configure estas variáveis com suas credenciais do Supabase
        // Encontre-as em: https://app.supabase.com > Seu Projeto > Settings > API
        let supabaseURL = "https://czplchozqdzvxquopzon.supabase.co"
        let supabaseKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImN6cGxjaG96cWR6dnhxdW9wem9uIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjI2NTA5MTQsImV4cCI6MjA3ODIyNjkxNH0.qWY2svQorgi0Nq5Mq_J1turNDvcsE7mFkUKlauNojaE"
        
        guard let url = URL(string: supabaseURL) else {
            fatalError("URL do Supabase inválida. Configure em SupabaseClient.swift")
        }
        
        self.baseURL = url
        self.apiKey = supabaseKey
    }
    
    // MARK: - Auth Client (Interface compatível)
    
    struct AuthClient {
        let supabase: SupabaseClient
        
        var session: SupabaseSession? {
            get async throws {
                try await supabase.getCurrentSession()
            }
        }
        
        func signIn(email: String, password: String) async throws -> SupabaseSession {
            try await supabase.signIn(email: email, password: password)
        }
        
        func signUp(email: String, password: String) async throws -> SupabaseSession {
            try await supabase.signUp(email: email, password: password)
        }
        
        func signOut() async throws {
            try await supabase.signOut()
        }
    }
    
    lazy var auth: AuthClient = {
        AuthClient(supabase: self)
    }()
    
    // MARK: - Métodos de Autenticação
    
    private func getCurrentSession() async throws -> SupabaseSession {
        guard let accessToken = userDefaults.string(forKey: accessTokenKey),
              let refreshToken = userDefaults.string(forKey: refreshTokenKey) else {
            throw NSError(domain: "SupabaseAuth", code: 401, userInfo: [NSLocalizedDescriptionKey: "Nenhuma sessão ativa"])
        }
        
        // Verificar se o token ainda é válido fazendo uma requisição ao user
        let url = baseURL.appendingPathComponent("auth/v1/user")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue(apiKey, forHTTPHeaderField: "apikey")
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            // Token inválido, limpar e lançar erro
            userDefaults.removeObject(forKey: accessTokenKey)
            userDefaults.removeObject(forKey: refreshTokenKey)
            throw NSError(domain: "SupabaseAuth", code: 401, userInfo: [NSLocalizedDescriptionKey: "Sessão expirada"])
        }
        
        let user = try JSONDecoder().decode(SupabaseUser.self, from: data)
        
        return SupabaseSession(
            accessToken: accessToken,
            tokenType: "bearer",
            expiresIn: 3600,
            refreshToken: refreshToken,
            user: user
        )
    }
    
    private func signIn(email: String, password: String) async throws -> SupabaseSession {
        let url = baseURL.appendingPathComponent("auth/v1/token")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(apiKey, forHTTPHeaderField: "apikey")
        
        let body: [String: Any] = [
            "email": email,
            "password": password,
            "grant_type": "password"
        ]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NSError(domain: "SupabaseAuth", code: -1, userInfo: [NSLocalizedDescriptionKey: "Resposta inválida do servidor"])
        }
        
        guard httpResponse.statusCode == 200 else {
            let errorMessage = String(data: data, encoding: .utf8) ?? "Erro de autenticação"
            throw NSError(domain: "SupabaseAuth", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])
        }
        
        let session = try JSONDecoder().decode(SupabaseSession.self, from: data)
        
        // Salvar tokens
        userDefaults.set(session.accessToken, forKey: accessTokenKey)
        userDefaults.set(session.refreshToken, forKey: refreshTokenKey)
        
        return session
    }
    
    private func signUp(email: String, password: String) async throws -> SupabaseSession {
        let url = baseURL.appendingPathComponent("auth/v1/signup")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(apiKey, forHTTPHeaderField: "apikey")
        
        let body: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NSError(domain: "SupabaseAuth", code: -1, userInfo: [NSLocalizedDescriptionKey: "Resposta inválida do servidor"])
        }
        
        guard httpResponse.statusCode == 200 else {
            let errorMessage = String(data: data, encoding: .utf8) ?? "Erro ao criar conta"
            throw NSError(domain: "SupabaseAuth", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])
        }
        
        let authResponse = try JSONDecoder().decode(SupabaseAuthResponse.self, from: data)
        
        guard let session = authResponse.session else {
            throw NSError(domain: "SupabaseAuth", code: -1, userInfo: [NSLocalizedDescriptionKey: "Sessão não retornada"])
        }
        
        // Salvar tokens
        userDefaults.set(session.accessToken, forKey: accessTokenKey)
        userDefaults.set(session.refreshToken, forKey: refreshTokenKey)
        
        return session
    }
    
    private func signOut() async throws {
        guard let accessToken = userDefaults.string(forKey: accessTokenKey) else {
            return // Já está deslogado
        }
        
        let url = baseURL.appendingPathComponent("auth/v1/logout")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue(apiKey, forHTTPHeaderField: "apikey")
        
        _ = try await session.data(for: request)
        
        // Limpar tokens locais
        userDefaults.removeObject(forKey: accessTokenKey)
        userDefaults.removeObject(forKey: refreshTokenKey)
    }
    
    // MARK: - PostgREST Client (Interface compatível)
    
    struct PostgRESTClient {
        let supabase: SupabaseClient
        
        func from(_ table: String) -> PostgRESTQueryBuilder {
            PostgRESTQueryBuilder(supabase: supabase, table: table)
        }
    }
    
    lazy var postgrest: PostgRESTClient = {
        PostgRESTClient(supabase: self)
    }()
    
    // MARK: - Functions Client (Interface compatível)
    
    struct FunctionsClient {
        let supabase: SupabaseClient
        
        func invoke(functionName: String, body: [String: Any]? = nil) async throws -> Data {
            try await supabase.invokeFunction(functionName: functionName, body: body)
        }
    }
    
    lazy var functions: FunctionsClient = {
        FunctionsClient(supabase: self)
    }()
    
    private func invokeFunction(functionName: String, body: [String: Any]? = nil) async throws -> Data {
        let url = baseURL.appendingPathComponent("functions/v1/\(functionName)")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(apiKey, forHTTPHeaderField: "apikey")
        
        if let accessToken = userDefaults.string(forKey: accessTokenKey) {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        if let body = body {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        }
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NSError(domain: "SupabaseFunctions", code: -1, userInfo: [NSLocalizedDescriptionKey: "Erro ao invocar função"])
        }
        
        return data
    }
}

// MARK: - PostgREST Query Builder

struct PostgRESTQueryBuilder {
    let supabase: SupabaseClient
    let table: String
    private var selectColumns: String = "*"
    private var filters: [(column: String, operator: String, value: String)] = []
    private var limitValue: Int?
    
    init(supabase: SupabaseClient, table: String) {
        self.supabase = supabase
        self.table = table
    }
    
    func select(_ columns: String = "*") -> PostgRESTQueryBuilder {
        var builder = self
        builder.selectColumns = columns
        return builder
    }
    
    func eq(_ column: String, value: String) -> PostgRESTQueryBuilder {
        var builder = self
        builder.filters.append((column: column, operator: "eq", value: value))
        return builder
    }
    
    func limit(_ count: Int) -> PostgRESTQueryBuilder {
        var builder = self
        builder.limitValue = count
        return builder
    }
    
    func execute() async throws -> (data: Data, response: HTTPURLResponse) {
        var urlComponents = URLComponents(url: supabase.baseURL.appendingPathComponent("rest/v1/\(table)"), resolvingAgainstBaseURL: false)!
        
        // Adicionar select
        urlComponents.queryItems = [URLQueryItem(name: "select", value: selectColumns)]
        
        // Adicionar filtros
        for filter in filters {
            urlComponents.queryItems?.append(URLQueryItem(name: "\(filter.column)", value: filter.operator + "." + filter.value))
        }
        
        // Adicionar limit
        if let limit = limitValue {
            urlComponents.queryItems?.append(URLQueryItem(name: "limit", value: String(limit)))
        }
        
        guard let url = urlComponents.url else {
            throw NSError(domain: "PostgREST", code: -1, userInfo: [NSLocalizedDescriptionKey: "URL inválida"])
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(supabase.apiKey, forHTTPHeaderField: "apikey")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("return=representation", forHTTPHeaderField: "Prefer")
        
        if let accessToken = supabase.userDefaults.string(forKey: supabase.accessTokenKey) {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        let (data, response) = try await supabase.session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NSError(domain: "PostgREST", code: -1, userInfo: [NSLocalizedDescriptionKey: "Resposta inválida"])
        }
        
        return (data, httpResponse)
    }
}
