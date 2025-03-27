//
//  Injection.swift
//  ProjectDicoding3
//
//  Created by Mario Alexander on 3/20/25.
//

import Foundation
import RealmSwift

final class Injection: NSObject {

    private func provideRepository() -> AppsRepositoryProtocol {
        let realm = try? Realm()

        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)

        return AppsRepository.sharedInstance(remote, locale)
    }

    func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }

    func provideDetail(game: GameModel) -> DetailGameUseCase {
        let repository = provideRepository()
        return DetailGameInteractor(repository: repository, game: game)
    }

    func provideFavorite() -> FavoriteUseCase {
        let repository = provideRepository()
        return FavoriteInteractor(repository: repository)
    }

    func provideProfile() -> ProfileUseCase {
        let repository = provideRepository()
        return ProfileInteractor(repository: repository)
    }

}
