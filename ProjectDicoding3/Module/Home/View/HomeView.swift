//
//  HomeView.swift
//  ProjectDicoding3
//
//  Created by Mario Alexander on 3/19/25.
//

import SwiftUI

struct HomeView: View {

    @ObservedObject var presenter: HomePresenter

    var body: some View {
        ZStack {
            if presenter.isLoading {
                loadingIndicator
            } else if presenter.isError {
                errorIndicator
            } else if presenter.gameList.isEmpty {
                emptyCategories
            } else {
                content
            }
        }
        .onAppear {
            presenter.getGameList()
        }
        .navigationBarTitle(
            Text("Games Apps"),
            displayMode: .automatic
        )
    }
}

extension HomeView {
    var loadingIndicator: some View {
        VStack {
            Text("Loading...")
            ActivityIndicator()
        }
    }

    var errorIndicator: some View {
        CustomEmptyView(
            image: "assetSearchNotFound",
            title: presenter.errorMessage
        ).offset(y: 80)
    }

    var emptyCategories: some View {
        CustomEmptyView(
            image: "assetNoFavorite",
            title: "Game List is empty"
        ).offset(y: 80)
    }

    var content: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(presenter.gameList, id: \.id) { game in
                    self.presenter.linkBuilder(for: game) {
                        GameListRow(game: game, background: Color.purple)
                            .padding(.bottom, 10)
                    }.buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
        }
    }
}
