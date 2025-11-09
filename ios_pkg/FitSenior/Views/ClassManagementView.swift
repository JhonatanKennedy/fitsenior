import SwiftUI

struct ClassManagementView: View {
    let classId: String
    @StateObject private var dbService = DatabaseService.shared
    @State private var classData: Class?
    @State private var students: [Student] = []
    @State private var messages: [ForumMessage] = []
    @State private var newMessage = ""
    @State private var attendance: [String: Bool] = [:]
    @State private var notes = ""
    @State private var isLoading = true
    @State private var selectedTab = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if isLoading {
                    ProgressView("Carregando...")
                        .padding()
                } else {
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text(classData?.activity ?? "")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        if let classData = classData {
                            Text("\(classData.schedule) • \(classData.location)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    
                    // Tabs
                    Picker("", selection: $selectedTab) {
                        Text("Lista de Chamada").tag(0)
                        Text("Fórum").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    
                    // Content
                    Group {
                        switch selectedTab {
                        case 0:
                            attendanceView
                        case 1:
                            forumView
                        default:
                            EmptyView()
                        }
                    }
                }
            }
        }
        .navigationTitle("Gerenciar Turma")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await loadData()
        }
    }
    
    private var attendanceView: some View {
        VStack(spacing: 16) {
            CardView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Presença de Hoje")
                        .font(.headline)
                    
                    Text("Marque os alunos presentes na aula")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    ForEach(students) { student in
                        HStack {
                            Text(student.email)
                            Spacer()
                            Text("\(student.absences) faltas")
                                .foregroundColor(.secondary)
                            Toggle("", isOn: Binding(
                                get: { attendance[student.id] ?? false },
                                set: { attendance[student.id] = $0 }
                            ))
                        }
                    }
                    
                    PrimaryButton(title: "Salvar Presença") {
                        Task {
                            await saveAttendance()
                        }
                    }
                }
                .padding()
            }
            .padding(.horizontal)
            
            CardView {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Observações da Turma")
                        .font(.headline)
                    
                    TextArea(
                        title: "",
                        text: $notes,
                        placeholder: "Adicione observações sobre a turma...",
                        height: 100
                    )
                }
                .padding()
            }
            .padding(.horizontal)
        }
    }
    
    private var forumView: some View {
        VStack(spacing: 16) {
            CardView {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Enviar Mensagem")
                        .font(.headline)
                    
                    TextArea(
                        title: "",
                        text: $newMessage,
                        placeholder: "Digite sua mensagem...",
                        height: 80
                    )
                    
                    PrimaryButton(title: "Enviar") {
                        Task {
                            await sendMessage()
                        }
                    }
                }
                .padding()
            }
            .padding(.horizontal)
            
            ForEach(messages) { message in
                CardView {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text(message.profile?.fullName ?? "Usuário")
                                .font(.headline)
                            Spacer()
                            if let createdAt = message.createdAt {
                                Text(formatDate(createdAt))
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                        Text(message.message)
                            .font(.subheadline)
                    }
                    .padding()
                }
                .padding(.horizontal)
            }
        }
    }
    
    private func loadData() async {
        isLoading = true
        // Carregar dados
        isLoading = false
    }
    
    private func saveAttendance() async {
        // Salvar presença
    }
    
    private func sendMessage() async {
        guard !newMessage.isEmpty else { return }
        // Enviar mensagem
        newMessage = ""
        await loadData()
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: date)
    }
}

#Preview {
    NavigationView {
        ClassManagementView(classId: "test-id")
    }
}

