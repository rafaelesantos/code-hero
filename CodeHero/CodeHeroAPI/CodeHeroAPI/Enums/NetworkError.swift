//
//  NetworkError.swift
//  CodeHeroAPI
//
//  Created by Rafael Escaleira on 15/07/21.
//

import Foundation

public enum NetworkError: Error {
    case dataNotFound
    case decodeFailure(_ detail: String)
    case detail(_ detail: String)

    public var string: String {
        switch self {
        case .dataNotFound: return "No data Found"
        case let .decodeFailure(detail): return "Decode Failure: \(detail)"
        case let .detail(detail): return "Error Detail: \(detail)"
        }
    }
}
