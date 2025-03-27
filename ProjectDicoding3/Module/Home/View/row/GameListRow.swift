//
//  gameListRow.swift
//  ProjectDicoding3
//
//  Created by Mario Alexander on 3/20/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameListRow: View {
    let game: GameModel
    let background: Color
    var body: some View {
        VStack {
            imageCategory
            content
        }
        .frame(width: UIScreen.main.bounds.width - 32, height: 250)
        .background(background.opacity(0.3))
        .cornerRadius(30)
    }
}

extension GameListRow {
    var imageCategory: some View {
        WebImage(url: URL(string: game.backgroundImage))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFit()
            .frame(width: 200)
            .cornerRadius(30)
            .padding(.top)
    }

    var content: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(game.name)
                .font(.title)
                .bold()

            Text(game.released)
                .font(.system(size: 14))
                .lineLimit(2)
        }.padding(
            EdgeInsets(
                top: 0,
                leading: 16,
                bottom: 16,
                trailing: 16
            )
        )
    }
}
