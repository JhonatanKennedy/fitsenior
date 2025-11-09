import SwiftUI

struct SearchClassesView: View {
    @State private var searchLocation = ""
    @State private var categoryFilter = "all"
    @State private var levelFilter = "all"
    @State private var classes: [Class] = []
    
    let categories = ["all": "Todas", "outdoor": "Ao Ar Livre", "yoga": "Yoga", 
                     "gym": "Musculação", "pilates": "Pilates", "water": "Hidroginástica"]
    
    let levels = ["all": "Todos", "Iniciante": "Iniciante", 
                 "Intermediário": "Intermediário", "Todos os níveis": "Flexível"]
    
    var filteredClasses: [Class] {
        classes.filter { classItem in
            let matchesLocation = searchLocation.isEmpty || 
                classItem.location.localizedCaseInsensitiveContains(searchLocation)
            // Adicionar mais filtros conforme necessário
            return matchesLocation
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Encontre Sua Aula")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("Descubra atividades físicas próximas a você")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    
                    // Filters
                    CardView {
                        VStack(spacing: 16) {
                            TextInput(
                                title: "Localização",
                                text: $searchLocation,
                                placeholder: "Digite sua localização..."
                            )
                            
                            Picker("Categoria", selection: $categoryFilter) {
                                ForEach(Array(categories.keys.sorted()), id: \.self) { key in
                                    Text(categories[key] ?? "").tag(key)
                                }
                            }
                            
                            Picker("Nível", selection: $levelFilter) {
                                ForEach(Array(levels.keys.sorted()), id: \.self) { key in
                                    Text(levels[key] ?? "").tag(key)
                                }
                            }
                        }
                        .padding()
                    }
                    .padding(.horizontal)
                    
                    // Results Count
                    Text("\(filteredClasses.count) \(filteredClasses.count == 1 ? "aula encontrada" : "aulas encontradas")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    // Classes Grid
                    if filteredClasses.isEmpty {
                        CardView {
                            VStack(spacing: 16) {
                                Text("Nenhuma aula encontrada com os filtros selecionados.")
                                    .foregroundColor(.secondary)
                                
                                OutlineButton(title: "Limpar Filtros") {
                                    searchLocation = ""
                                    categoryFilter = "all"
                                    levelFilter = "all"
                                }
                            }
                            .padding()
                        }
                        .padding(.horizontal)
                    } else {
                        ForEach(filteredClasses) { classItem in
                            ClassSearchCard(classItem: classItem)
                                .padding(.horizontal)
                        }
                    }
                }
            }
            .navigationTitle("Buscar Aulas")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ClassSearchCard: View {
    let classItem: Class
    
    var body: some View {
        CardView {
            VStack(alignment: .leading, spacing: 12) {
                // Image placeholder
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 150)
                    .cornerRadius(8)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(classItem.activity)
                        .font(.headline)
                    
                    HStack {
                        Image(systemName: "mappin")
                        Text(classItem.location)
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    
                    HStack {
                        Image(systemName: "clock")
                        Text(classItem.schedule)
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    
                    HStack {
                        Image(systemName: "person.2")
                        Text("\(classItem.maxStudents) vagas disponíveis")
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                .padding()
                
                HStack {
                    if let price = classItem.price {
                        Text("R$ \(price, specifier: "%.2f")/mês")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    }
                    
                    Spacer()
                    
                    PrimaryButton(title: "Reservar") {}
                }
                .padding()
            }
        }
    }
}

#Preview {
    SearchClassesView()
}

