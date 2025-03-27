//
//  FavoriteView.swift
//  ProjectDicoding3
//
//  Created by Mario Alexander on 3/20/25.
//

import SwiftUI

struct FavoriteView: View {

    @ObservedObject var presenter: FavoritePresenter

    var body: some View {
        ZStack {
            if presenter.favoriteGames.isEmpty {
                emptyCategories
            } else {
                content
            }
        }
        .onAppear {
            presenter.getFavoriteGames()
        }
        .navigationBarTitle(
            Text("Favorites"),
            displayMode: .automatic
        )
    }
}

extension FavoriteView {

    var emptyCategories: some View {
        CustomEmptyView(
            image: "assetNoFavorite",
            title: "Your Favorite is empty"
        ).offset(y: 50)
    }

    var content: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(presenter.favoriteGames, id: \.id) { game in
                    self.presenter.linkBuilder(for: game) {
                        GameListRow(game: game, background: Color.red)
                            .padding(.bottom, 10)
                    }.buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
        }
    }
}
