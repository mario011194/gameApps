//
//  ProjectDicoding3App.swift
//  ProjectDicoding3
//
//  Created by Mario Alexander on 3/19/25.
//

import SwiftUI

@main
struct ProjectDicoding3App: App {
    let homePresenter: HomePresenter
    let favoritePresenter: FavoritePresenter
    let profilePresenter: ProfilePresenter

    init() {
        let homeUseCase = Injection().provideHome()
        self.homePresenter = HomePresenter(homeUseCase: homeUseCase)
        let favoriteUseCase = Injection().provideFavorite()
        self.favoritePresenter = FavoritePresenter(favoriteUseCase: favoriteUseCase)
        let profileUseCase = Injection().provideProfile()
        self.profilePresenter = ProfilePresenter(profileUseCase: profileUseCase)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(homePresenter)
                .environmentObject(favoritePresenter)
                .environmentObject(profilePresenter)
        }
    }
}
