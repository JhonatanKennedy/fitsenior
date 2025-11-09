import Foundation

struct Demand: Codable, Identifiable {
    let id: String
    let activity: String
    let neighborhood: String
    let schedule: String
    let numInterested: Int
    let location: String
    let createdAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case id
        case activity
        case neighborhood
        case schedule
        case numInterested = "num_interested"
        case location
        case createdAt = "created_at"
    }
}

