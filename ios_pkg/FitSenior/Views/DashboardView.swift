import SwiftUI

struct DashboardView: View {
    @StateObject private var authService = AuthService.shared
    @StateObject private var dbService = DatabaseService.shared
    @State private var professional: Professional?
    @State private var classes: [Class] = []
    @State private var demands: [Demand] = []
    @State private var isLoading = true
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                if isLoading {
                    ProgressView("Carregando...")
                } else {
                    ScrollView {
                        VStack(spacing: 20) {
                            // Header
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Dashboard")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                    
                                    if let professional = professional {
                                        Text("Olá, \(professional.fullName)!")
                                            .font(.title3)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    Task {
                                        try? await authService.signOut()
                                    }
                                }) {
                                    Text("Sair")
                                        .foregroundColor(.blue)
                                }
                            }
                            .padding()
                            
                            // Stats Cards
                            HStack(spacing: 12) {
                                StatCard(
                                    title: "Receita Total",
                                    value: String(format: "R$ %.2f", totalRevenue),
                                    icon: "dollarsign.circle.fill"
                                )
                                
                                StatCard(
                                    title: "Total de Alunos",
                                    value: "\(totalStudents)",
                                    icon: "person.2.fill"
                                )
                                
                                StatCard(
                                    title: "Demandas",
                                    value: "\(demands.count)",
                                    icon: "chart.line.uptrend.xyaxis"
                                )
                            }
                            .padding(.horizontal)
                            
                            // Tabs
                            Picker("", selection: $selectedTab) {
                                Text("Minhas Turmas").tag(0)
                                Text("Demandas").tag(1)
                                Text("Financeiro").tag(2)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding(.horizontal)
                            
                            // Content
                            Group {
                                switch selectedTab {
                                case 0:
                                    classesView
                                case 1:
                                    demandsView
                                case 2:
                                    financialView
                                default:
                                    EmptyView()
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .task {
                await loadData()
            }
        }
    }
    
    private var classesView: some View {
        VStack(spacing: 12) {
            if classes.isEmpty {
                CardView {
                    VStack(spacing: 16) {
                        Text("Você ainda não tem turmas cadastradas.")
                            .foregroundColor(.secondary)
                        
                        NavigationLink(destination: CreateClassView()) {
                            PrimaryButton(title: "Cadastrar Primeira Turma") {}
                        }
                    }
                    .padding()
                }
                .padding(.horizontal)
            } else {
                ForEach(classes) { classItem in
                    NavigationLink(destination: ClassManagementView(classId: classItem.id)) {
                        ClassCard(classItem: classItem)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    private var demandsView: some View {
        VStack(spacing: 12) {
            ForEach(demands) { demand in
                DemandCard(demand: demand)
            }
            .padding(.horizontal)
        }
    }
    
    private var financialView: some View {
        NavigationLink(destination: FinancialView()) {
            CardView {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Receita por Turma")
                        .font(.headline)
                    
                    ForEach(classes) { classItem in
                        // Financial breakdown
                        Text(classItem.activity)
                            .font(.subheadline)
                    }
                }
                .padding()
            }
            .padding(.horizontal)
        }
    }
    
    private var totalRevenue: Double {
        // Calcular receita total
        return 0.0
    }
    
    private var totalStudents: Int {
        // Calcular total de alunos
        return 0
    }
    
    private func loadData() async {
        isLoading = true
        // Carregar dados
        isLoading = false
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        CardView {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(title)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                    Image(systemName: icon)
                        .foregroundColor(.secondary)
                }
                
                Text(value)
                    .font(.title2)
                    .fontWeight(.bold)
            }
            .padding()
        }
    }
}

struct ClassCard: View {
    let classItem: Class
    
    var body: some View {
        CardView {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(classItem.activity)
                        .font(.headline)
                    Spacer()
                    Text("0 alunos")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Image(systemName: "clock")
                    Text(classItem.schedule)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                HStack {
                    Image(systemName: "mappin")
                    Text(classItem.location)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                HStack {
                    Image(systemName: "dollarsign.circle")
                    if let price = classItem.price {
                        Text("R$ \(price, specifier: "%.2f")/mês por aluno")
                    }
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
            }
            .padding()
        }
    }
}

struct DemandCard: View {
    let demand: Demand
    
    var body: some View {
        CardView {
            VStack(alignment: .leading, spacing: 12) {
                Text(demand.activity)
                    .font(.headline)
                
                Text("\(demand.numInterested) idosos interessados")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                HStack {
                    Image(systemName: "mappin")
                    Text("\(demand.neighborhood) - \(demand.location)")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                HStack {
                    Image(systemName: "clock")
                    Text(demand.schedule)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                NavigationLink(destination: CreateClassView(demand: demand)) {
                    PrimaryButton(title: "Criar Turma") {}
                }
            }
            .padding()
        }
    }
}

#Preview {
    DashboardView()
}

