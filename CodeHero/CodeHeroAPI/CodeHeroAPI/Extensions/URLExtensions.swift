//
//  URLExtensions.swift
//  CodeHeroAPI
//
//  Created by Rafael Escaleira on 15/07/21.
//

import Foundation

extension URL {
    func appendingPath(_ path: String?) -> Self {
        guard let path = path else { return self }
        guard let urlWithPath = URL(string: self.absoluteString + path) else { return self }
        return urlWithPath
    }
}
