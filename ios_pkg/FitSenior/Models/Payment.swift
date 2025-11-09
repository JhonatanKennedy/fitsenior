import Foundation

struct Payment: Codable, Identifiable {
    let id: String
    let classId: String
    let enrollmentId: String
    let amount: Double
    let status: String?
    let paymentDate: String?
    let createdAt: Date?
    let classActivity: String?
    let studentName: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case classId = "class_id"
        case enrollmentId = "enrollment_id"
        case amount
        case status
        case paymentDate = "payment_date"
        case createdAt = "created_at"
        case classActivity
        case studentName
    }
}

