//
//  CustomerError+Ext.swift
//  ProjectDicoding3
//
//  Created by Mario Alexander on 3/20/25.
//

import Foundation

enum URLError: LocalizedError {

  case invalidResponse
  case addressUnreachable(URL)
    case invalidURL

  var errorDescription: String? {
    switch self {
    case .invalidResponse: return "The server responded with garbage."
    case .addressUnreachable(let url): return "\(url.absoluteString) is unreachable."
    case .invalidURL: return "Invalid URl"
    }
  }

}

enum DatabaseError: LocalizedError {

  case invalidInstance
  case requestFailed

  var errorDescription: String? {
    switch self {
    case .invalidInstance: return "Database can't instance."
    case .requestFailed: return "Your request failed."
    }
  }

}
