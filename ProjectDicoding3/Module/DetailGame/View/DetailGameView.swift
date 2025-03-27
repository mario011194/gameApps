//
//  DetailGameView.swift
//  ProjectDicoding3
//
//  Created by Mario Alexander on 3/20/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailGameView: View {
    @ObservedObject var presenter: DetailGamePresenter

    var body: some View {
        ZStack {
            if presenter.isLoading {
                loadingIndicator
            } else if presenter.isError {
                errorIndicator
            } else {
                ScrollView(.vertical) {
                    VStack {
                        content
                    }.padding()
                }
            }
        }
        .onAppear {
            presenter.getDetailGame()
        }
        .navigationBarTitle(Text(self.presenter.detail?.name ?? ""), displayMode: .large)
    }
}

extension DetailGameView {
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

    var imageCategory: some View {
        WebImage(url: URL(string: self.presenter.detail?.backgroundImage ?? ""))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFit()
            .frame(width: 200)
            .cornerRadius(30)
            .padding()
    }

    var content: some View {
        VStack(spacing: 0) {
            imageCategory

            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    StarRatingView(rating: presenter.detail?.rating ?? 0.0)

                    Spacer()

                    Button {
                        presenter.toggleFavorite()
                    } label: {
                        Image(systemName: presenter.isFavorite ? "heart.fill" : "heart")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.red)
                    }

                }

                Text("Release: \(presenter.detail?.released ?? "")")
                    .font(.system(size: 14))

                Text("Genre: \(presenter.genre)")
                    .font(.system(size: 14))

                Text("Platform: \(presenter.platformGame)")
                    .font(.system(size: 14))

                Text("Description: \(presenter.detail?.description.stripHTML() ?? "")")
                    .font(.system(size: 12))
            }
        }
    }
}
