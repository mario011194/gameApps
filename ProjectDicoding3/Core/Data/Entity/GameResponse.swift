//
//  GameResponse.swift
//  ProjectDicoding3
//
//  Created by Mario Alexander on 3/20/25.
//

import Foundation

struct GameResponse: Codable {
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let id: Int?
    let name, released: String?
    let backgroundImage: String?
    let rating: Double?
    let platforms: [PlatformElement]?
    let genres: [Genre]?
    let description: String?
    let isFavorite: Bool?

    init(
        id: Int?,
        name: String?,
        released: String?,
        backgroundImage: String?,
        rating: Double?,
        platforms: [PlatformElement]? = nil,
        genres: [Genre]? = nil,
        description: String?,
        isFavorite: Bool? = false
    ) {
        self.id = id
        self.name = name
        self.released = released
        self.backgroundImage = backgroundImage
        self.rating = rating
        self.platforms = platforms
        self.genres = genres
        self.description = description
        self.isFavorite = isFavorite
    }

    enum CodingKeys: String, CodingKey {
        case id, name, released
        case backgroundImage = "background_image"
        case rating
        case platforms
        case genres
        case description
        case isFavorite
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name, slug: String
    let gamesCount: Int
    let imageBackground: String
    let domain: String?
    let language: Language?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case domain, language
    }
}

enum Language: String, Codable {
    case eng = "eng"
}

// MARK: - PlatformElement
struct PlatformElement: Codable {
    let platform: PlatformPlatform
    let releasedAt: String?
    let requirementsEn, requirementsRu: Requirements?

    enum CodingKeys: String, CodingKey {
        case platform
        case releasedAt = "released_at"
        case requirementsEn = "requirements_en"
        case requirementsRu = "requirements_ru"
    }
}

// MARK: - PlatformPlatform
struct PlatformPlatform: Codable {
    let id: Int
    let name, slug: String
    let image, yearEnd: JSONNull?
    let yearStart: Int?
    let gamesCount: Int
    let imageBackground: String

    enum CodingKeys: String, CodingKey {
        case id, name, slug, image
        case yearEnd = "year_end"
        case yearStart = "year_start"
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}

// MARK: - Requirements
struct Requirements: Codable {
    let minimum: String
    let recommended: String?
}

// MARK: - Rating
struct Rating: Codable {
    let id: Int
    let title: Title
    let count: Int
    let percent: Double
}

enum Title: String, Codable {
    case exceptional = "exceptional"
    case meh = "meh"
    case recommended = "recommended"
    case skip = "skip"
}

// MARK: - ShortScreenshot
struct ShortScreenshot: Codable {
    let id: Int
    let image: String
}

// MARK: - Store
struct Store: Codable {
    let id: Int
    let store: Genre
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
