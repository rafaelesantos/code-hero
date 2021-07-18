//
//  Character.swift
//  CodeHeroAPI
//
//  Created by Rafael Escaleira on 15/07/21.
//

import Foundation

public struct Character: Codable {
    public var code: Int?
    public var status: String?
    public var copyright: String?
    public var attributionText: String?
    public var attributionHTML: String?
    public var etag: String?
    public var data: CharacterData?
    
    public struct CharacterData: Codable {
        public var offset: Int?
        public var limit: Int?
        public var total: Int?
        public var count: Int?
        public var results: [Result]?
        
        public struct Result: Codable {
            public var id: Int?
            public var name: String?
            public var description: String?
            public var modified: String?
            public var thumbnail: Thumbnail?
            public var resourceURI: String?
            public var comics: RelatedFeature?
            public var series: RelatedFeature?
            public var stories: RelatedFeature?
            public var events: RelatedFeature?
            public var urls: [Url]?
            
            public struct Thumbnail: Codable {
                public var path: String?
                public var _extension: String?
                
                enum CodingKeys: String, CodingKey {
                    case path = "path"
                    case _extension = "extension"
                }
            }
            
            public struct RelatedFeature: Codable {
                public var available: Int?
                public var collectionURI: String?
                public var items: [Item]?
                public var returned: Int?
            }
            
            public struct Url: Codable {
                public var type: String?
                public var url: String?
            }
            
            public struct Item: Codable {
                public var resourceURI: String?
                public var name: String?
                public var type: String?
            }
        }
    }
}
