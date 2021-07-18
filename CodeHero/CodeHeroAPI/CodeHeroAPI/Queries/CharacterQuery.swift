//
//  CharacterQuery.swift
//  CodeHeroAPI
//
//  Created by Rafael Escaleira on 15/07/21.
//

import Foundation

public enum CharacterQuery: RestQuery {
    public enum OrderBy: String {
        case ascName = "name"
        case ascModified = "modified"
        case descName = "-name"
        case descModified = "-modified"
    }
    case characters(nameStartsWith: String? = nil,
                    orderBy: OrderBy = .descModified,
                    limit: Int = 4,
                    offset: Int = 0)
    public var path: String {
        switch self {
        case .characters(let nameStartsWith,
                         let orderBy,
                         let limit,
                         let offset):
            let authQuery = CodeHeroAPI.shared.getAuthMD5()
            var query = "characters?"
            query += "orderBy=\(orderBy.rawValue)&"
            query += "limit=\(limit)&"
            query += "offset=\(offset)&"
            query += "ts=\(authQuery.0)&"
            query += "apikey=\(authQuery.1)&"
            query += "hash=\(authQuery.2)"
            if let nameStartsWith = nameStartsWith { query += "&nameStartsWith=\(nameStartsWith)" }
            return query
        }
    }
    public var method: NetworkMethod { .get }
}
