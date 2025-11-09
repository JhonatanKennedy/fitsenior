import Foundation

struct Enrollment: Codable, Identifiable {
    let id: String
    let classId: String
    let studentId: String
    let status: String?
    let createdAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case id
        case classId = "class_id"
        case studentId = "student_id"
        case status
        case createdAt = "created_at"
    }
}

struct Student: Codable, Identifiable {
    let id: String
    let enrollmentId: String
    let email: String
    let absences: Int
}

