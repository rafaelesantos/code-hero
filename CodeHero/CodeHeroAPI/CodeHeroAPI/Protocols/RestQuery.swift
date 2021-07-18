//
//  RestQuery.swift
//  CodeHeroAPI
//
//  Created by Rafael Escaleira on 15/07/21.
//

import Foundation

public protocol RestQuery {
    var path: String { get }
    var method: NetworkMethod { get }
}

extension RestQuery {
    public func asURLRequest(_ endpoint: URL) -> URLRequest {
        let url = endpoint
            .appendingPath(path)

        let urlRequest = URLRequest(url: url)
            .appendingHttpMethod(method)

        return urlRequest
    }
    public func asURLRequest() -> URLRequest? {
        let urlFromPath = URL(string: path)
        guard let url = urlFromPath else { return nil }

        let urlRequest = URLRequest(url: url)
            .appendingHttpMethod(method)

        return urlRequest
    }
}
