import SwiftUI

struct AuthView: View {
    @StateObject private var authService = AuthService.shared
    @State private var email = ""
    @State private var password = ""
    @State private var isSignUp = false
    @State private var showingError = false
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Logo/Header
                        VStack(spacing: 8) {
                            Image(systemName: "heart.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.blue)
                            
                            Text("FitSênior")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            
                            Text("Conectando gerações através do movimento")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.top, 40)
                        
                        // Auth Form
                        CardView {
                            VStack(spacing: 20) {
                                // Tabs
                                Picker("", selection: $isSignUp) {
                                    Text("Login").tag(false)
                                    Text("Cadastro").tag(true)
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                .padding()
                                
                                // Form Fields
                                VStack(spacing: 16) {
                                    TextInput(
                                        title: "Email",
                                        text: $email,
                                        placeholder: "seu@email.com",
                                        keyboardType: .emailAddress
                                    )
                                    
                                    TextInput(
                                        title: "Senha",
                                        text: $password,
                                        placeholder: "••••••••",
                                        isSecure: true
                                    )
                                }
                                .padding(.horizontal)
                                
                                // Submit Button
                                PrimaryButton(
                                    title: isSignUp ? "Cadastrar" : "Entrar",
                                    action: {
                                        Task {
                                            do {
                                                if isSignUp {
                                                    try await authService.signUp(email: email, password: password)
                                                } else {
                                                    try await authService.signIn(email: email, password: password)
                                                }
                                            } catch {
                                                showingError = true
                                            }
                                        }
                                    },
                                    isLoading: authService.isLoading
                                )
                                .padding(.horizontal)
                                .padding(.bottom)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationBarHidden(true)
            .alert("Erro", isPresented: $showingError) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(authService.errorMessage ?? "Ocorreu um erro")
            }
        }
    }
}

#Preview {
    AuthView()
}

