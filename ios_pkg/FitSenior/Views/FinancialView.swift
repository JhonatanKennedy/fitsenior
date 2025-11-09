import SwiftUI

struct FinancialView: View {
    @StateObject private var dbService = DatabaseService.shared
    @State private var payments: [Payment] = []
    @State private var monthlyTotal: Double = 0
    @State private var yearlyTotal: Double = 0
    @State private var isLoading = true
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if isLoading {
                    ProgressView("Carregando...")
                        .padding()
                } else {
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Financeiro")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("Acompanhe seus ganhos e pagamentos")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    
                    // Stats
                    HStack(spacing: 12) {
                        StatCard(
                            title: "Total no Mês",
                            value: String(format: "R$ %.2f", monthlyTotal),
                            icon: "calendar"
                        )
                        
                        StatCard(
                            title: "Total no Ano",
                            value: String(format: "R$ %.2f", yearlyTotal),
                            icon: "chart.line.uptrend.xyaxis"
                        )
                    }
                    .padding(.horizontal)
                    
                    // Payments List
                    CardView {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Histórico de Pagamentos")
                                .font(.headline)
                            
                            Text("Lista completa de todos os pagamentos recebidos")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            if payments.isEmpty {
                                Text("Nenhum pagamento registrado ainda")
                                    .foregroundColor(.secondary)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                            } else {
                                ForEach(payments) { payment in
                                    PaymentRow(payment: payment)
                                }
                            }
                        }
                        .padding()
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationTitle("Financeiro")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await loadPayments()
        }
    }
    
    private func loadPayments() async {
        isLoading = true
        // Carregar pagamentos
        isLoading = false
    }
}

struct PaymentRow: View {
    let payment: Payment
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading) {
                    Text(payment.studentName ?? "N/A")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    
                    Text(payment.classActivity ?? "N/A")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("R$ \(payment.amount, specifier: "%.2f")")
                        .font(.headline)
                    
                    Text(payment.status == "paid" ? "Pago" : "Pendente")
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(payment.status == "paid" ? Color.green.opacity(0.2) : Color.orange.opacity(0.2))
                        .foregroundColor(payment.status == "paid" ? .green : .orange)
                        .cornerRadius(4)
                }
            }
            
            if let paymentDate = payment.paymentDate {
                Text(formatDate(paymentDate))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color(.systemGray5)),
            alignment: .bottom
        )
    }
    
    private func formatDate(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: dateString) {
            formatter.dateStyle = .short
            formatter.locale = Locale(identifier: "pt_BR")
            return formatter.string(from: date)
        }
        return dateString
    }
}

#Preview {
    NavigationView {
        FinancialView()
    }
}

