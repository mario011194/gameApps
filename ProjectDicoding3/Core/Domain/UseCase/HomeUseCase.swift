//
//  HomeUseCase.swift
//  ProjectDicoding3
//
//  Created by Mario Alexander on 3/20/25.
//

import Foundation
import Combine

protocol HomeUseCase {
    func getGameList() -> AnyPublisher<[GameModel], Error>
}

class HomeInteractor: HomeUseCase {

    private let repository: AppsRepositoryProtocol

    required init(repository: AppsRepositoryProtocol) {
        self.repository = repository
    }

    func getGameList() -> AnyPublisher<[GameModel], Error> {
        return repository.getGameList()
    }
}
