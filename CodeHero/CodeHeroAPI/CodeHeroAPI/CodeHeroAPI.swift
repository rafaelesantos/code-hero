//
//  CodeHeroAPI.swift
//  CodeHeroAPI
//
//  Created by Rafael Escaleira on 15/07/21.
//

import Foundation
import CryptoKit

public final class CodeHeroAPI: NetworkProtocol {
    private var baseURL: String {
        get { self.getGlobalInfoBy(key: "Base URL") }
    }
    
    private var publicKey: String {
        get { self.getGlobalInfoBy(key: "API Public Key") }
    }
    
    private var privateKey: String {
        get { self.getGlobalInfoBy(key: "API Private Key") }
    }
    
    var endpoint: URL? { URL(string: baseURL) }
    var session: URLSession?
    
    public static var shared: NetworkProtocolType = CodeHeroAPI()
    
    internal lazy var sessionRest: URLSession? = {
        let client = URLSession(configuration: .default)
        return client
    }()
    
    public func call<T: RestQuery, U: Decodable>(_ query: T,
                                                 _ decodable: U.Type,
                                                 _ completion: @escaping NetworkCompletion<U>) {
        guard let endpoint = endpoint else { return }
        let urlRequest = query.asURLRequest(endpoint)
        
        sessionRest?.dataTask(with: urlRequest) { data, _, error in
            completion(self.handle(data, error))
        }.resume()
    }
    
    private func getGlobalInfoBy(key: String) -> String {
        guard let filePath = Bundle(for: CodeHeroAPI.self).path(forResource: "Global", ofType: "plist") else {
            fatalError("Couldn't find file 'Global.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: key) as? String else {
            fatalError("Couldn't find key 'BaseURL' in 'Global.plist'. Base URL not Found")
        }
        return value
    }
    
    public func getAuthMD5() -> (Int, String, String) {
        let ts = Int(Date().timeIntervalSince1970)
        let hash = "\(ts)\(self.privateKey)\(self.publicKey)"
        let digest = Insecure.MD5.hash(data: hash.data(using: .utf8) ?? Data())
        return (ts, publicKey, digest.map { String(format: "%02hhx", $0) }.joined())
    }
}
