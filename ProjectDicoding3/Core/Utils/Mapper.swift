//
//  Mapper.swift
//  ProjectDicoding3
//
//  Created by Mario Alexander on 3/25/25.
//

import Foundation

final class GameMapper {
    static func mapGameResponsesToDomains(input gameResponses: [Result]) -> [GameModel] {
        return gameResponses.map { result in
            return GameModel(
                id: result.id ?? 0,
                name: result.name ?? "Unknown",
                released: result.released ?? "Unknown",
                backgroundImage: result.backgroundImage ?? "",
                rating: result.rating ?? 0.0,
                platforms: result.platforms?.compactMap { platformElement in
                    GameModel.PlatformElement(
                        platform: GameModel.PlatformPlatform(
                            id: platformElement.platform.id,
                            name: platformElement.platform.name,
                            slug: platformElement.platform.slug,
                            image: nil,
                            yearEnd: nil,
                            yearStart: nil,
                            gamesCount: 0,
                            imageBackground: ""
                        ),
                        releasedAt: platformElement.releasedAt,
                        requirementsEn: platformElement.requirementsEn,
                        requirementsRu: platformElement.requirementsRu
                    )
                } ?? [],
                genres: result.genres?.compactMap { genreElement in
                    GameModel.Genre(
                        id: genreElement.id,
                        name: genreElement.name,
                        slug: genreElement.slug,
                        gamesCount: genreElement.gamesCount,
                        imageBackground: genreElement.imageBackground,
                        domain: genreElement.domain,
                        language: genreElement.language
                    )
                } ?? [],
                description: result.description ?? "No Description",
                isFavorite: result.isFavorite ?? false
            )
        }
    }

    static func mapDomainToResult(game: GameModel) -> Result {
        return Result(
            id: game.id,
            name: game.name,
            released: game.released,
            backgroundImage: game.backgroundImage,
            rating: game.rating,
            platforms: game.platforms.map {
                PlatformElement(
                    platform: PlatformPlatform(
                        id: $0.platform.id,
                        name: $0.platform.name,
                        slug: $0.platform.slug,
                        image: $0.platform.image,
                        yearEnd: $0.platform.yearEnd,
                        yearStart: $0.platform.yearStart,
                        gamesCount: $0.platform.gamesCount,
                        imageBackground: $0.platform.imageBackground
                    ),
                    releasedAt: $0.releasedAt,
                    requirementsEn: $0.requirementsEn,
                    requirementsRu: $0.requirementsRu
                )
            },
            genres: game.genres.map {
                Genre(
                    id: $0.id,
                    name: $0.name,
                    slug: $0.slug,
                    gamesCount: $0.gamesCount,
                    imageBackground: $0.imageBackground,
                    domain: $0.domain,
                    language: $0.language
                )
            },
            description: game.description,
            isFavorite: game.isFavorite
        )
    }
}
