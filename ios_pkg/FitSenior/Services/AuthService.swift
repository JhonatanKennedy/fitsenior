import Foundation
import Combine

class AuthService: ObservableObject {
    static let shared = AuthService()
    
    @Published var currentUser: User?
    @Published var isAuthenticated = false
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // Modo de desenvolvimento: ative para pular autenticação
    private let developmentMode = true // Mude para false quando quiser usar autenticação real
    
    private let supabase = SupabaseClient.shared
    
    private init() {
        if developmentMode {
            // Modo desenvolvimento: autenticar automaticamente
            setupDevelopmentMode()
        } else {
            checkAuthState()
        }
    }
    
    private func setupDevelopmentMode() {
        // Criar usuário fictício para desenvolvimento
        self.currentUser = User(
            id: "dev-user-123",
            email: "dev@fitsenior.com",
            fullName: "Usuário Desenvolvimento"
        )
        self.isAuthenticated = true
        self.isLoading = false
    }
    
    func checkAuthState() {
        isLoading = true
        // Verificar se há sessão ativa
        // Implementação real com Supabase
        Task {
            do {
                if let session = try await supabase.auth.session {
                    await MainActor.run {
                        let user = session.user
                        self.currentUser = User(
                            id: user.id.uuidString,
                            email: user.email,
                            fullName: nil
                        )
                        self.isAuthenticated = true
                        self.isLoading = false
                    }
                } else {
                    await MainActor.run {
                        self.isAuthenticated = false
                        self.isLoading = false
                    }
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
                let user = session.user
                self.currentUser = User(
                    id: user.id.uuidString,
                    email: user.email,
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
                let user = session.user
                self.currentUser = User(
                    id: user.id.uuidString,
                    email: user.email,
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

