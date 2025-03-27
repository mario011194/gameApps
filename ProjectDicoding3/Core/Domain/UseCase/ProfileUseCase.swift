//
//  ProfileUseCase.swift
//  ProjectDicoding3
//
//  Created by Mario Alexander on 3/20/25.
//

import Foundation
import Combine

protocol ProfileUseCase {

}

class ProfileInteractor: ProfileUseCase {

    private let repository: AppsRepositoryProtocol

    required init(repository: AppsRepositoryProtocol) {
        self.repository = repository
    }

}
