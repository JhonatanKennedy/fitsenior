import Foundation

struct User: Codable, Identifiable {
    let id: String
    let email: String?
    let fullName: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case fullName = "full_name"
    }
}

struct Profile: Codable, Identifiable {
    let id: String
    let fullName: String?
    let createdAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case createdAt = "created_at"
    }
}

