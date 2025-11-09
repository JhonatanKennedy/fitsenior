import Foundation

struct Professional: Codable, Identifiable {
    let id: String
    let userId: String
    let cref: String
    let fullName: String
    let birthDate: String
    let specialty: String
    let cpf: String
    let createdAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case cref
        case fullName = "full_name"
        case birthDate = "birth_date"
        case specialty
        case cpf
        case createdAt = "created_at"
    }
}

struct ProfessionalRegistration: Codable {
    let cref: String
    let fullName: String
    let birthDate: String
    let specialty: String
    let cpf: String
    
    enum CodingKeys: String, CodingKey {
        case cref
        case fullName = "full_name"
        case birthDate = "birth_date"
        case specialty
        case cpf
    }
}

