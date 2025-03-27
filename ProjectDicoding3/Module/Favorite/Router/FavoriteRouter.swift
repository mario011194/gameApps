//
//  FavoriteRouter.swift
//  ProjectDicoding3
//
//  Created by Mario Alexander on 3/20/25.
//

import Foundation
import SwiftUI

class FavoriteRouter {

    func makeDetailView(for game: GameModel) -> some View {
        let detailUseCase = Injection.init().provideDetail(game: game)
        let presenter = DetailGamePresenter(detailUseCase: detailUseCase)
        return DetailGameView(presenter: presenter)
    }

}
