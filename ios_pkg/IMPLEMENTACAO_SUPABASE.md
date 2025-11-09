# Guia de Implementação do Supabase

Este guia explica como implementar a integração real com Supabase no app iOS.

## 📦 Instalação do Supabase Swift SDK

### Via Swift Package Manager

1. No Xcode, vá em `File > Add Package Dependencies...`
2. Cole a URL: `https://github.com/supabase/supabase-swift`
3. Selecione a versão `2.0.0` ou superior
4. Adicione ao target `FitSenior`

## 🔧 Implementação do SupabaseClient

Atualize o arquivo `FitSenior/Services/SupabaseClient.swift`:

```swift
import Foundation
import Supabase

class SupabaseClient {
    static let shared = SupabaseClient()
    
    let client: SupabaseClient
    
    private init() {
        let url = URL(string: Config.supabaseURL)!
        let key = Config.supabaseKey
        
        self.client = SupabaseClient(supabaseURL: url, supabaseKey: key)
    }
}
```

## 🔐 Implementação do AuthService

Atualize `FitSenior/Services/AuthService.swift`:

```swift
import Foundation
import Combine
import Supabase

class AuthService: ObservableObject {
    static let shared = AuthService()
    
    @Published var currentUser: User?
    @Published var isAuthenticated = false
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let supabase = SupabaseClient.shared.client
    
    private init() {
        checkAuthState()
    }
    
    func checkAuthState() {
        isLoading = true
        Task {
            do {
                let session = try await supabase.auth.session
                await MainActor.run {
                    if let user = session.user {
                        self.currentUser = User(
                            id: user.id.uuidString,
                            email: user.email,
                            fullName: nil
                        )
                        self.isAuthenticated = true
                    }
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.isAuthenticated = false
                    self.isLoading = false
                }
            }
        }
    }
    
    func signIn(email: String, password: String) async throws {
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }
        
        do {
            let session = try await supabase.auth.signIn(
                email: email,
                password: password
            )
            
            await MainActor.run {
                self.currentUser = User(
                    id: session.user.id.uuidString,
                    email: session.user.email,
                    fullName: nil
                )
                self.isAuthenticated = true
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
            throw error
        }
    }
    
    func signUp(email: String, password: String) async throws {
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }
        
        do {
            let session = try await supabase.auth.signUp(
                email: email,
                password: password
            )
            
            await MainActor.run {
                self.currentUser = User(
                    id: session.user.id.uuidString,
                    email: session.user.email,
                    fullName: nil
                )
                self.isAuthenticated = true
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
            throw error
        }
    }
    
    func signOut() async throws {
        do {
            try await supabase.auth.signOut()
            await MainActor.run {
                self.currentUser = nil
                self.isAuthenticated = false
            }
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
            throw error
        }
    }
}
```

## 🗄️ Implementação do DatabaseService

Atualize `FitSenior/Services/DatabaseService.swift`:

```swift
import Foundation
import Combine
import Supabase

class DatabaseService: ObservableObject {
    static let shared = DatabaseService()
    
    private let supabase = SupabaseClient.shared.client
    
    private init() {}
    
    // MARK: - Professionals
    
    func getProfessional(userId: String) async throws -> Professional? {
        let response: [Professional] = try await supabase
            .from("professionals")
            .select()
            .eq("user_id", value: userId)
            .execute()
            .value
        
        return response.first
    }
    
    func createProfessional(_ professional: ProfessionalRegistration) async throws -> Professional {
        let response: Professional = try await supabase
            .from("professionals")
            .insert(professional)
            .select()
            .single()
            .execute()
            .value
        
        return response
    }
    
    // MARK: - Classes
    
    func getClasses(professionalId: String) async throws -> [Class] {
        let response: [Class] = try await supabase
            .from("classes")
            .select()
            .eq("professional_id", value: professionalId)
            .execute()
            .value
        
        return response
    }
    
    func getClass(id: String) async throws -> Class? {
        let response: Class = try await supabase
            .from("classes")
            .select()
            .eq("id", value: id)
            .single()
            .execute()
            .value
        
        return response
    }
    
    func createClass(_ classData: CreateClassRequest) async throws -> Class {
        let response: Class = try await supabase
            .from("classes")
            .insert(classData)
            .select()
            .single()
            .execute()
            .value
        
        return response
    }
    
    // MARK: - Demands
    
    func getDemands() async throws -> [Demand] {
        let response: [Demand] = try await supabase
            .from("demands")
            .select()
            .order("created_at", ascending: false)
            .execute()
            .value
        
        return response
    }
    
    // MARK: - Enrollments
    
    func getEnrollments(classId: String) async throws -> [Enrollment] {
        let response: [Enrollment] = try await supabase
            .from("enrollments")
            .select()
            .eq("class_id", value: classId)
            .eq("status", value: "active")
            .execute()
            .value
        
        return response
    }
    
    // MARK: - Attendance
    
    func saveAttendance(_ records: [AttendanceRecord]) async throws {
        try await supabase
            .from("attendance")
            .upsert(records)
            .execute()
    }
    
    // MARK: - Forum Messages
    
    func getForumMessages(classId: String) async throws -> [ForumMessage] {
        let response: [ForumMessage] = try await supabase
            .from("forum_messages")
            .select("""
                *,
                profiles:user_id (
                    id,
                    full_name
                )
            """)
            .eq("class_id", value: classId)
            .order("created_at", ascending: false)
            .execute()
            .value
        
        return response
    }
    
    func createForumMessage(_ message: CreateMessageRequest) async throws -> ForumMessage {
        let response: ForumMessage = try await supabase
            .from("forum_messages")
            .insert(message)
            .select("""
                *,
                profiles:user_id (
                    id,
                    full_name
                )
            """)
            .single()
            .execute()
            .value
        
        return response
    }
    
    // MARK: - Payments
    
    func getPayments(professionalId: String) async throws -> [Payment] {
        // Query mais complexa com joins
        let response: [Payment] = try await supabase
            .from("payments")
            .select("""
                *,
                classes:class_id (
                    activity
                ),
                enrollments:enrollment_id (
                    profiles:student_id (
                        full_name
                    )
                )
            """)
            .eq("classes.professional_id", value: professionalId)
            .order("created_at", ascending: false)
            .execute()
            .value
        
        // Transformar resposta para o modelo Payment
        return response.map { payment in
            // Mapear campos aninhados
            Payment(
                id: payment.id,
                classId: payment.classId,
                enrollmentId: payment.enrollmentId,
                amount: payment.amount,
                status: payment.status,
                paymentDate: payment.paymentDate,
                createdAt: payment.createdAt,
                classActivity: nil, // Preencher do join
                studentName: nil // Preencher do join
            )
        }
    }
}
```

## 📝 Notas Importantes

### 1. Decodificação de Datas

O Supabase retorna datas como strings ISO 8601. Você pode precisar de um `DateFormatter` customizado:

```swift
extension DateFormatter {
    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
}
```

### 2. Tratamento de Erros

Sempre trate erros adequadamente:

```swift
do {
    let data = try await dbService.getClasses()
    // Usar dados
} catch {
    print("Erro ao carregar classes: \(error)")
    // Mostrar erro ao usuário
}
```

### 3. Queries com Joins

Para queries complexas com joins, use a sintaxe do Supabase:

```swift
.select("""
    *,
    related_table:foreign_key (
        column1,
        column2
    )
""")
```

### 4. Real-time (Opcional)

Para funcionalidade real-time:

```swift
let channel = supabase.channel("classes")
channel.on(.postgresChanges(
    InsertAction(schema: "public", table: "classes")
)) { payload in
    // Atualizar UI
}
await channel.subscribe()
```

## ✅ Checklist de Implementação

- [ ] Supabase Swift SDK instalado
- [ ] Config.swift criado com credenciais
- [ ] SupabaseClient implementado
- [ ] AuthService implementado
- [ ] DatabaseService implementado
- [ ] Todas as queries testadas
- [ ] Tratamento de erros implementado
- [ ] App testado com dados reais

## 🔗 Recursos

- [Supabase Swift Documentation](https://github.com/supabase/supabase-swift)
- [Supabase JavaScript Client (referência)](https://supabase.com/docs/reference/javascript)
- [PostgREST API](https://postgrest.org/en/stable/api.html)

