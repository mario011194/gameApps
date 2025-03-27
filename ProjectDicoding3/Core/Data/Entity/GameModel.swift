//
//  GameModel.swift
//  ProjectDicoding3
//
//  Created by Mario Alexander on 3/25/25.
//

import Foundation

struct GameModel: Codable {
    let id: Int
    let name: String
    let released: String
    let backgroundImage: String
    let rating: Double
    let platforms: [PlatformElement]
    let genres: [Genre]
    let description: String
    let isFavorite: Bool
}

extension GameModel {
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
}
