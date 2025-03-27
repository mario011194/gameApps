//
//  FavoritePresenter.swift
//  ProjectDicoding3
//
//  Created by Mario Alexander on 3/20/25.
//

import SwiftUI
import Combine

class FavoritePresenter: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []
    private let router = FavoriteRouter()
    private let favoriteUseCase: FavoriteUseCase

    @Published var favoriteGames: [GameModel] = []

    init(favoriteUseCase: FavoriteUseCase) {
        self.favoriteUseCase = favoriteUseCase
    }

    func getFavoriteGames() {
        favoriteUseCase.getFavoriteGames()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] games in
                guard let self = self else { return }
                self.favoriteGames = games
            })
            .store(in: &cancellables)
    }

    func linkBuilder<Content: View>(for game: GameModel, @ViewBuilder content: () -> Content) -> some View {
      NavigationLink(
        destination: router.makeDetailView(for: game)) { content() }
    }

}
