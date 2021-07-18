//
//  CharacterService.swift
//  CodeHeroAPI
//
//  Created by Rafael Escaleira on 15/07/21.
//

import Foundation
import CodeHeroModels

public typealias CharacterCallback = (Result<Character?, NetworkError>) -> Void

public protocol CharacterServiceProtocol {
    func fetchCharacterData(callback: @escaping CharacterCallback)
}

public class CharacterService: CharacterServiceProtocol {
    private var network: NetworkProtocolType
    var query: CharacterQuery
    
    public init(network: NetworkProtocolType = CodeHeroAPI.shared,
                query: CharacterQuery) {
        self.network = network
        self.query = query
    }
    
    public func fetchCharacterData(callback: @escaping CharacterCallback) {
        network.call(query, Character.self) { result in
            switch result {
            case .success(let response):
                callback(.success(response))
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
}
