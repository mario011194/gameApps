//
//  HomeRouter.swift
//  ProjectDicoding3
//
//  Created by Mario Alexander on 3/19/25.
//

import SwiftUI

class HomeRouter {

    func makeDetailView(for game: GameModel) -> some View {
        let detailUseCase = Injection.init().provideDetail(game: game)
        let presenter = DetailGamePresenter(detailUseCase: detailUseCase)
        return DetailGameView(presenter: presenter)
    }

}
