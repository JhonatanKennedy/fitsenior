import Foundation

struct ForumMessage: Codable, Identifiable {
    let id: String
    let classId: String
    let userId: String
    let message: String
    let createdAt: Date?
    let profile: Profile?
    
    enum CodingKeys: String, CodingKey {
        case id
        case classId = "class_id"
        case userId = "user_id"
        case message
        case createdAt = "created_at"
        case profile
    }
}

struct CreateMessageRequest: Codable {
    let classId: String
    let userId: String
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case classId = "class_id"
        case userId = "user_id"
        case message
    }
}

