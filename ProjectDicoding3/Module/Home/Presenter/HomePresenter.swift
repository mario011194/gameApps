//
//  HomePresenter.swift
//  ProjectDicoding3
//
//  Created by Mario Alexander on 3/19/25.
//

import SwiftUI
import Combine

class HomePresenter: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []
    private let router = HomeRouter()
    private let homeUseCase: HomeUseCase

    @Published var gameList: [GameModel] = []
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false

    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }

    func getGameList() {
        isLoading = true
        homeUseCase.getGameList()
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
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                print("response \(response)")
                self.gameList = response
            })
            .store(in: &cancellables)
    }

    func linkBuilder<Content: View>(for game: GameModel, @ViewBuilder content: () -> Content) -> some View {
      NavigationLink(
        destination: router.makeDetailView(for: game)) { content() }
    }

}
