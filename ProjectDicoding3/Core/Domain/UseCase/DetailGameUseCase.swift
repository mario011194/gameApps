//
//  DetailGameUseCase.swift
//  ProjectDicoding3
//
//  Created by Mario Alexander on 3/20/25.
//

import Foundation
import Combine

protocol DetailGameUseCase {
    func getDetailGame() -> AnyPublisher<GameModel, Error>
    func isGameFavorite() -> AnyPublisher<Bool, Error>
    func toggleFavoriteGame() -> AnyPublisher<Bool, Error>
    func getFavoriteGames() -> AnyPublisher<[GameModel], Error>
}

class DetailGameInteractor: DetailGameUseCase {

    private let repository: AppsRepositoryProtocol
    private let game: GameModel

    required init(repository: AppsRepositoryProtocol, game: GameModel) {
        self.repository = repository
        self.game = game
    }

    func getDetailGame() -> AnyPublisher<GameModel, Error> {
        return repository.getDetailGame(with: game.id)
    }

    func isGameFavorite() -> AnyPublisher<Bool, Error> {
        return repository.isGameFavorite(id: game.id)
    }

    func toggleFavoriteGame() -> AnyPublisher<Bool, Error> {
        return repository.toggleFavoriteGame(game)
    }

    func getFavoriteGames() -> AnyPublisher<[GameModel], Error> {
        return repository.getFavoriteGames()
    }
}
