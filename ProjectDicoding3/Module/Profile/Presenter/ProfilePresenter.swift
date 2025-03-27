//
//  ProfilePresenter.swift
//  ProjectDicoding3
//
//  Created by Mario Alexander on 3/20/25.
//

import SwiftUI
import Combine

class ProfilePresenter: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []
    private let router = ProfileRouter()
    private let profileUseCase: ProfileUseCase

    init(profileUseCase: ProfileUseCase) {
        self.profileUseCase = profileUseCase
    }

}
