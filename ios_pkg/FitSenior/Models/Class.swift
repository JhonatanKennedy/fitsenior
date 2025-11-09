import Foundation

struct Class: Codable, Identifiable {
    let id: String
    let professionalId: String
    let activity: String
    let description: String?
    let schedule: String
    let maxStudents: Int
    let location: String
    let price: Double?
    let demandId: String?
    let createdAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case id
        case professionalId = "professional_id"
        case activity
        case description
        case schedule
        case maxStudents = "max_students"
        case location
        case price
        case demandId = "demand_id"
        case createdAt = "created_at"
    }
}

struct ClassWithEnrollments: Codable {
    let id: String
    let activity: String
    let schedule: String
    let location: String
    let price: Double?
    let enrollments: [EnrollmentCount]
    
    enum CodingKeys: String, CodingKey {
        case id
        case activity
        case schedule
        case location
        case price
        case enrollments
    }
}

struct EnrollmentCount: Codable {
    let count: Int
}

struct CreateClassRequest: Codable {
    let professionalId: String
    let activity: String
    let description: String?
    let schedule: String
    let maxStudents: Int
    let location: String
    let price: Double?
    let demandId: String?
    
    enum CodingKeys: String, CodingKey {
        case professionalId = "professional_id"
        case activity
        case description
        case schedule
        case maxStudents = "max_students"
        case location
        case price
        case demandId = "demand_id"
    }
}

