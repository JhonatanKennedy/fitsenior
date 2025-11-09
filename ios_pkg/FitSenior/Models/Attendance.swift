import Foundation

struct Attendance: Codable, Identifiable {
    let id: String
    let enrollmentId: String
    let date: String
    let present: Bool?
    let createdAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case id
        case enrollmentId = "enrollment_id"
        case date
        case present
        case createdAt = "created_at"
    }
}

struct AttendanceRecord: Codable {
    let enrollmentId: String
    let date: String
    let present: Bool
    
    enum CodingKeys: String, CodingKey {
        case enrollmentId = "enrollment_id"
        case date
        case present
    }
}

