import SwiftUI

struct ProfessionalRegistrationView: View {
    @StateObject private var authService = AuthService.shared
    @StateObject private var dbService = DatabaseService.shared
    @State private var cref = ""
    @State private var fullName = ""
    @State private var birthDate = Date()
    @State private var specialty = ""
    @State private var cpf = ""
    @State private var isLoading = false
    @State private var showingError = false
    @State private var errorMessage = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                VStack(spacing: 8) {
                    Text("Cadastro Profissional")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Complete seu perfil para começar a oferecer aulas")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 20)
                
                // Form
                CardView {
                    VStack(spacing: 20) {
                        TextInput(
                            title: "CREF *",
                            text: $cref,
                            placeholder: "Ex: 123456-G/SP"
                        )
                        
                        TextInput(
                            title: "Nome Completo *",
                            text: $fullName,
                            placeholder: "Digite seu nome completo"
                        )
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Data de Nascimento *")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            DatePicker("", selection: $birthDate, displayedComponents: .date)
                                .datePickerStyle(CompactDatePickerStyle())
                        }
                        
                        TextInput(
                            title: "Especialidade *",
                            text: $specialty,
                            placeholder: "Ex: Yoga, Pilates, Musculação"
                        )
                        
                        TextInput(
                            title: "CPF *",
                            text: $cpf,
                            placeholder: "000.000.000-00",
                            keyboardType: .numberPad
                        )
                        
                        PrimaryButton(
                            title: "Concluir Cadastro",
                            action: {
                                Task {
                                    await registerProfessional()
                                }
                            },
                            isLoading: isLoading
                        )
                    }
                    .padding()
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("Cadastro")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Erro", isPresented: $showingError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(errorMessage)
        }
    }
    
    private func registerProfessional() async {
        isLoading = true
        
        // Validação
        guard !cref.isEmpty, !fullName.isEmpty, !specialty.isEmpty, !cpf.isEmpty else {
            errorMessage = "Por favor, preencha todos os campos obrigatórios."
            showingError = true
            isLoading = false
            return
        }
        
        // Criar perfil profissional
        // Implementação real aqui
        
        isLoading = false
    }
}

#Preview {
    NavigationView {
        ProfessionalRegistrationView()
    }
}

