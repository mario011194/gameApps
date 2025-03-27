//
//  RemoteDataSource.swift
//  ProjectDicoding3
//
//  Created by Mario Alexander on 3/20/25.
//

import Foundation
import Alamofire
import Combine

protocol RemoteDataSourceProtocol: AnyObject {
    func getGameList() -> AnyPublisher<GameResponse, Error>
    func getDetailList(with id: Int) -> AnyPublisher<Result, Error>
}

final class RemoteDataSource: NSObject {

    private override init() { }

    static let sharedInstance: RemoteDataSource =  RemoteDataSource()

}

extension RemoteDataSource: RemoteDataSourceProtocol {

    func getGameList() -> AnyPublisher<GameResponse, Error> {
        return Future<GameResponse, Error> { completion in
            guard let url = URL(string: Endpoints.Gets.gameList.url) else {
                completion(.failure(URLError.invalidURL))
                return
            }

            AF.request(url)
                .validate()
                .responseDecodable(of: GameResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        completion(.success(value))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
        .eraseToAnyPublisher()
    }

    func getDetailList(with id: Int) -> AnyPublisher<Result, Error> {
        return Future<Result, Error> { completion in
            guard let url = URL(string: Endpoints.Gets.detailGame(id: id).url) else {
                completion(.failure(URLError.invalidURL))
                return
            }

            AF.request(url)
                .validate()
                .responseDecodable(of: Result.self) { response in
                    switch response.result {
                    case .success(let value):
                        completion(.success(value))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
        .eraseToAnyPublisher()
    }

}
