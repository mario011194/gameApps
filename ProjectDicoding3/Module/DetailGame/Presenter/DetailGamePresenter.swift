//
//  DetailGamePresenter.swift
//  ProjectDicoding3
//
//  Created by Mario Alexander on 3/20/25.
//

import SwiftUI
import Combine

class DetailGamePresenter: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []
    private let router = DetailGameRouter()
    private let detailUseCase: DetailGameUseCase

    @Published var detail: GameModel?
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var isFavorite: Bool = false
    @Published var favoriteGames: [GameModel] = []

    var genre = ""
    var platformGame = ""
    var requirement = ""

    init(detailUseCase: DetailGameUseCase) {
        self.detailUseCase = detailUseCase
    }

    func getDetailGame() {
        isLoading = true
        detailUseCase.getDetailGame()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { [weak self] detail in
                guard let self = self else { return }
                let requirementRec = detail.platforms.compactMap { $0.requirementsEn?.recommended }
                let platform = detail.platforms.map { $0.platform.name }
                let genre2 = detail.genres.map { $0.name }

                self.detail = detail
                requirement = requirementRec.joined(separator: ",")
                genre = genre2.joined(separator: ",")
                platformGame = platform.joined(separator: ",")
                checkIfFavorite()
            })
            .store(in: &cancellables)
    }

    func checkIfFavorite() {
        detailUseCase.isGameFavorite()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] isFavorite in
                self?.isFavorite = isFavorite
            })
            .store(in: &cancellables)
    }

    func toggleFavorite() {
        detailUseCase.toggleFavoriteGame()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] isFavorite in
                self?.isFavorite = isFavorite
                self?.getFavoriteGames()
            })
            .store(in: &cancellables)
    }

    func getFavoriteGames() {
        detailUseCase.getFavoriteGames()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] games in
                self?.favoriteGames = games
            })
            .store(in: &cancellables)
    }

}
