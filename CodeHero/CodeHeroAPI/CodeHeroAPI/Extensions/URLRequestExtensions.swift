//
//  URLRequestExtensions.swift
//  CodeHeroAPI
//
//  Created by Rafael Escaleira on 15/07/21.
//

import Foundation

extension URLRequest {
    mutating func appendHttpMethod(_ method: NetworkMethod) {
        httpMethod = method.rawValue
    }

    func appendingHttpMethod(_ method: NetworkMethod) -> URLRequest {
        var urlRequest = self
        urlRequest.appendHttpMethod(method)
        return urlRequest
    }
}
