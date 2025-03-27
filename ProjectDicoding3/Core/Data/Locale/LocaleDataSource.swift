//
//  LocaleDataSource.swift
//  ProjectDicoding3
//
//  Created by Mario Alexander on 3/20/25.
//

import RealmSwift
import Combine
import Foundation

protocol LocaleDataSourceProtocol: AnyObject {
    func getGameList() -> AnyPublisher<[Result], Error>
    func addGames(_ games: [Result]) -> AnyPublisher<Bool, Error>
    func getFavoriteGames() -> AnyPublisher<[Result], Error>
    func isGameFavorite(id: Int) -> AnyPublisher<Bool, Error>
    func toggleFavoriteGame(_ game: Result) -> AnyPublisher<Bool, Error>
}

final class LocaleDataSource: NSObject {

    private let realm: Realm?

    private init(realm: Realm?) {
        self.realm = realm
    }

    static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in
        return LocaleDataSource(realm: realmDatabase)
    }

}

extension LocaleDataSource: LocaleDataSourceProtocol {

    func getGameList() -> AnyPublisher<[Result], Error> {
        let games = realm?.objects(GameEntity.self).map { $0.toDomain() } ?? []
        return Just(Array(games))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func addGames(_ games: [Result]) -> AnyPublisher<Bool, Error> {
        do {
            try realm?.write {
                let entities = games.map { GameEntity.fromDomain($0) }
                realm?.add(entities, update: .modified)
            }
            return Just(true)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }

    func getFavoriteGames() -> AnyPublisher<[Result], Error> {
        let favorites = realm?.objects(GameEntity.self).filter("isFavorite == true").map { $0.toDomain() } ?? []
        return Just(Array(favorites))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func isGameFavorite(id: Int) -> AnyPublisher<Bool, Error> {
        let favorite = realm?.object(ofType: GameEntity.self, forPrimaryKey: id)?.isFavorite ?? false
        return Just(favorite)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func toggleFavoriteGame(_ game: Result) -> AnyPublisher<Bool, Error> {
        do {
            guard let realm = realm else {
                return Fail(
                    error: NSError(
                        domain: "RealmError",
                        code: 0,
                        userInfo: [NSLocalizedDescriptionKey: "Realm not initialized"]
                    )
                )
                    .eraseToAnyPublisher()
            }

            try realm.write {
                if let existingGame = realm.object(ofType: GameEntity.self, forPrimaryKey: game.id) {
                    existingGame.isFavorite.toggle()
                } else {
                    let entity = GameEntity.fromDomain(game)
                    entity.isFavorite = true
                    realm.add(entity, update: .modified)
                }
            }

            let isFavoriteNow = realm.object(ofType: GameEntity.self, forPrimaryKey: game.id)?.isFavorite ?? false
            return Just(isFavoriteNow)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()

        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }

}
