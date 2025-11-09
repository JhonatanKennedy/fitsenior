import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 40) {
                    // Hero Section
                    VStack(spacing: 20) {
                        // Imagem do logo (se você adicionar uma imagem chamada "Logo" no Assets)
                        Image("Logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                        
                        // Ou use um ícone do sistema por enquanto
                        //Image(systemName: "heart.fill")
                        //    .font(.system(size: 60))
                        //    .foregroundColor(.blue)
                        
                        Text("Conectando Idosos a Profissionais de Educação Física")
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                        
                        Text("Encontre aulas de atividade física perto de você, com profissionais qualificados e horários flexíveis.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        
                        NavigationLink(destination: SearchClassesView()) {
                            Text("Começar Agora")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        
                        NavigationLink(destination: CreateClassView()) {
                            Text("Sou Profissional")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(.systemGray6))
                                .foregroundColor(.primary)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top, 40)
                    
                    // Stats
                    HStack(spacing: 30) {
                        StatItem(value: "500+", label: "Alunos Ativos")
                        StatItem(value: "100+", label: "Profissionais")
                        StatItem(value: "50+", label: "Locais")
                    }
                    .padding()
                }
            }
            .navigationTitle("FitSênior")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct StatItem: View {
    let value: String
    let label: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    HomeView()
}

