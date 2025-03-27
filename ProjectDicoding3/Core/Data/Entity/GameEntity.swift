//
//  GameEntity.swift
//  ProjectDicoding3
//
//  Created by Mario Alexander on 3/20/25.
//

import Foundation
import RealmSwift

class GameEntity: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var released: String?
    @Persisted var backgroundImage: String?
    @Persisted var rating: Double
    @Persisted var descriptionText: String?
    @Persisted var isFavorite: Bool = false

    func toDomain() -> Result {
        return Result(
            id: id,
            name: name,
            released: released,
            backgroundImage: backgroundImage,
            rating: rating,
            description: descriptionText,
            isFavorite: isFavorite
        )
    }

    static func fromDomain(_ model: Result) -> GameEntity {
        let entity = GameEntity()
        entity.id = model.id ?? 0
        entity.name = model.name ?? ""
        entity.released = model.released
        entity.backgroundImage = model.backgroundImage
        entity.rating = model.rating ?? 0.0
        entity.descriptionText = model.description
        entity.isFavorite = model.isFavorite ?? false
        return entity
    }
}
