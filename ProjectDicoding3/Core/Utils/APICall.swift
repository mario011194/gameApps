//
//  APICall.swift
//  ProjectDicoding3
//
//  Created by Mario Alexander on 3/20/25.
//

import Foundation

struct API {
    static let baseUrl = "https://api.rawg.io"
    static let apiKey = "8356978ac55c4a3cb46b57d01cfb46e9"
}

protocol Endpoint {
    var url: String { get }
}

enum Endpoints {
    enum Gets: Endpoint {
        case gameList
        case detailGame(id: Int)

        public var url: String {
            switch self {
            case .gameList:
                return "\(API.baseUrl)/api/games?key=\(API.apiKey)"
            case .detailGame(let id):
                return "\(API.baseUrl)/api/games/\(id)?key=\(API.apiKey)"
            }
        }
    }
}
