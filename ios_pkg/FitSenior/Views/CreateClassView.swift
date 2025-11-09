import SwiftUI

struct CreateClassView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var dbService = DatabaseService.shared
    @State private var title = ""
    @State private var description = ""
    @State private var category = ""
    @State private var location = ""
    @State private var schedule = ""
    @State private var maxStudents = ""
    @State private var price = ""
    @State private var level = ""
    @State private var isLoading = false
    @State private var showingError = false
    @State private var errorMessage = ""
    
    let demand: Demand?
    
    init(demand: Demand? = nil) {
        self.demand = demand
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("Cadastrar Nova Aula")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Preencha as informações da sua aula para começar a receber alunos")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
                // Form
                CardView {
                    VStack(spacing: 20) {
                        TextInput(
                            title: "Título da Aula *",
                            text: $title,
                            placeholder: "Ex: Yoga para Iniciantes"
                        )
                        
                        TextArea(
                            title: "Descrição",
                            text: $description,
                            placeholder: "Descreva sua aula, metodologia, benefícios...",
                            height: 120
                        )
                        
                        Picker("Categoria *", selection: $category) {
                            Text("Selecione...").tag("")
                            Text("Ao Ar Livre").tag("outdoor")
                            Text("Yoga").tag("yoga")
                            Text("Musculação").tag("gym")
                            Text("Pilates").tag("pilates")
                            Text("Hidroginástica").tag("water")
                            Text("Dança").tag("dance")
                            Text("Alongamento").tag("stretch")
                        }
                        
                        Picker("Nível *", selection: $level) {
                            Text("Selecione...").tag("")
                            Text("Iniciante").tag("Iniciante")
                            Text("Intermediário").tag("Intermediário")
                            Text("Avançado").tag("Avançado")
                            Text("Todos os níveis").tag("Todos os níveis")
                        }
                        
                        TextInput(
                            title: "Localização *",
                            text: $location,
                            placeholder: "Ex: Parque da Cidade, Rua das Flores, 123"
                        )
                        
                        TextInput(
                            title: "Horários *",
                            text: $schedule,
                            placeholder: "Ex: Segunda e Quarta, 8h às 9h"
                        )
                        
                        HStack(spacing: 16) {
                            TextInput(
                                title: "Vagas Disponíveis",
                                text: $maxStudents,
                                placeholder: "Ex: 15",
                                keyboardType: .numberPad
                            )
                            
                            TextInput(
                                title: "Valor Mensal (R$)",
                                text: $price,
                                placeholder: "Ex: 120",
                                keyboardType: .decimalPad
                            )
                        }
                        
                        PrimaryButton(
                            title: "Cadastrar Turma",
                            action: {
                                Task {
                                    await createClass()
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
        .navigationTitle("Nova Aula")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if let demand = demand {
                title = demand.activity
                location = demand.location
                schedule = demand.schedule
            }
        }
        .alert("Erro", isPresented: $showingError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(errorMessage)
        }
    }
    
    private func createClass() async {
        isLoading = true
        
        // Validação
        guard !title.isEmpty, !category.isEmpty, !location.isEmpty, !schedule.isEmpty else {
            errorMessage = "Por favor, preencha todos os campos obrigatórios."
            showingError = true
            isLoading = false
            return
        }
        
        // Criar turma
        // Implementação real aqui
        
        isLoading = false
        presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    NavigationView {
        CreateClassView()
    }
}

