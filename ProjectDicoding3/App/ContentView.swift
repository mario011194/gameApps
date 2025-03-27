//
//  ContentView.swift
//  ProjectDicoding3
//
//  Created by Mario Alexander on 3/19/25.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var homePresenter: HomePresenter
    @EnvironmentObject var favoritePresenter: FavoritePresenter
    @EnvironmentObject var profilePresenter: ProfilePresenter

    var body: some View {
        TabView {
            NavigationView {
                HomeView(presenter: homePresenter)
            }.tabItem {
                TabItem(imageName: "house", title: "Home")
            }

            NavigationView {
              FavoriteView(presenter: favoritePresenter)
            }.tabItem {
              TabItem(imageName: "heart", title: "Favorite")
            }

            NavigationView {
                ProfileView(presenter: profilePresenter)
            }.tabItem {
              TabItem(imageName: "person.circle", title: "Profile")
            }
        }
    }
}

#Preview {
    ContentView()
}

struct TabItem: View {

  var imageName: String
  var title: String
  var body: some View {
    VStack {
      Image(systemName: imageName)
      Text(title)
    }
  }

}
