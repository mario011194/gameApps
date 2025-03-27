//
//  FavoriteUseCase.swift
//  ProjectDicoding3
//
//  Created by Mario Alexander on 3/20/25.
//

import Foundation
import Combine

protocol FavoriteUseCase {
    func getFavoriteGames() -> AnyPublisher<[GameModel], Error>
}

class FavoriteInteractor: FavoriteUseCase {

    private let repository: AppsRepositoryProtocol

    required init(repository: AppsRepositoryProtocol) {
        self.repository = repository
    }

    func getFavoriteGames() -> AnyPublisher<[GameModel], Error> {
        return repository.getFavoriteGames()
    }

}
