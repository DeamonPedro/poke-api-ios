import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let types: [Type]
    let stats: [Stat]
    let sprites: Sprites
}

struct Type: Codable {
    let type: TypeInfo
}

struct TypeInfo: Codable {
    let name: String
}

struct Stat: Codable {
    let base_stat: Int
    let effort: Int
    let stat: StatInfo
}

struct StatInfo: Codable {
    let name: String
}

struct Sprites: Codable {
    let front_default: String
}
