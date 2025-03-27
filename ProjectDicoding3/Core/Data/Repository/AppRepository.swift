//
//  AppRepository.swift
//  ProjectDicoding3
//
//  Created by Mario Alexander on 3/20/25.
//

import Foundation
import Combine

protocol AppsRepositoryProtocol {
    func getGameList() -> AnyPublisher<[GameModel], Error>
    func getDetailGame(with id: Int) -> AnyPublisher<GameModel, Error>
    func getFavoriteGames() -> AnyPublisher<[GameModel], Error>
    func isGameFavorite(id: Int) -> AnyPublisher<Bool, Error>
    func toggleFavoriteGame(_ game: GameModel) -> AnyPublisher<Bool, Error>
}

final class AppsRepository: NSObject {

    typealias AppsInstance = (RemoteDataSource, LocaleDataSource) -> AppsRepository

    fileprivate let remote: RemoteDataSource
    fileprivate let local: LocaleDataSource

    private init(remote: RemoteDataSource, local: LocaleDataSource) {
        self.remote = remote
        self.local = local
    }

    static let sharedInstance: AppsInstance = { remoteRepo, localRepo in
        return AppsRepository(remote: remoteRepo, local: localRepo)
    }
}

extension AppsRepository: AppsRepositoryProtocol {
    func getGameList() -> AnyPublisher<[GameModel], Error> {
        return self.local.getGameList()
            .flatMap { cachedGames -> AnyPublisher<[GameModel], Error> in
                if cachedGames.isEmpty {
                    return self.remote.getGameList()
                        .map { $0.results }
                        .catch { _ in self.local.getGameList() }
                        .flatMap { games in self.local.addGames(games) }
                        .filter { $0 }
                        .flatMap { _ in self.local.getGameList() }
                        .map { GameMapper.mapGameResponsesToDomains(input: $0) }
                        .eraseToAnyPublisher()
                } else {
                    return self.local.getGameList()
                        .map { GameMapper.mapGameResponsesToDomains(input: $0) }
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }

    func getDetailGame(with id: Int) -> AnyPublisher<GameModel, Error> {
        return remote.getDetailList(with: id)
            .map { GameMapper.mapGameResponsesToDomains(input: [$0]).first! }
            .eraseToAnyPublisher()
    }

    func getFavoriteGames() -> AnyPublisher<[GameModel], Error> {
        return local.getFavoriteGames()
            .map { GameMapper.mapGameResponsesToDomains(input: $0) }
            .eraseToAnyPublisher()
    }

    func isGameFavorite(id: Int) -> AnyPublisher<Bool, Error> {
        return local.isGameFavorite(id: id)
    }

    func toggleFavoriteGame(_ game: GameModel) -> AnyPublisher<Bool, Error> {
        let result = GameMapper.mapDomainToResult(game: game)
        return local.toggleFavoriteGame(result)
    }
}
