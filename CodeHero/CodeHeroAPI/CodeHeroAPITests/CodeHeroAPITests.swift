//
//  CodeHeroAPITests.swift
//  CodeHeroAPITests
//
//  Created by Rafael Escaleira on 15/07/21.
//

import XCTest
@testable import CodeHeroAPI
@testable import CodeHeroModels

class CodeHeroAPITests: XCTestCase {
    var characterService: CharacterServiceProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.characterService = CharacterService(query: .characters())
    }
    
    override func tearDownWithError() throws {
        self.characterService = nil
        try super.tearDownWithError()
    }
    
    func testValidCharacterService() throws {
        let promise = expectation(description: "Status Code: 200")
        var responseError: Error?
        var responseCharacters: Character?
        
        self.characterService.fetchCharacterData { result in
            switch result {
            case .failure(let error): responseError = error
                promise.fulfill()
            case .success(let characters): responseCharacters = characters
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 5)
        
        XCTAssertNil(responseError)
        XCTAssertNotNil(responseCharacters)
        
        XCTAssertEqual(responseCharacters?.code, 200)
        XCTAssertEqual(responseCharacters?.data?.results?.count, 4)
    }
    
    func testSearchSpiderMan() throws {
        let promise = expectation(description: "Search Hero: Spider-man")
        var responseError: Error?
        var responseCharacters: Character?
        
        self.characterService = CharacterService(query: .characters(nameStartsWith: "Spider-man", orderBy: .ascName, limit: 4, offset: 0))
        self.characterService.fetchCharacterData { result in
            switch result {
            case .failure(let error): responseError = error
                promise.fulfill()
            case .success(let characters): responseCharacters = characters
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 5)
        
        XCTAssertNil(responseError)
        XCTAssertNotNil(responseCharacters)
        
        XCTAssertEqual(responseCharacters?.code, 200)
        XCTAssertEqual(responseCharacters?.data?.results?.first?.name?.lowercased().contains("spider-man"), true)
    }
    
    func testSwitchPage() throws {
        let promiseFirstPage = expectation(description: "Page: 1")
        let promiseSecondPage = expectation(description: "Page: 2")
        var responseErrorFirstPage: Error?
        var responseCharactersFirstPage: Character?
        var responseErrorSecondPage: Error?
        var responseCharactersSecondPage: Character?
        
        self.characterService = CharacterService(query: .characters(limit: 4, offset: 0))
        self.characterService.fetchCharacterData { result in
            switch result {
            case .failure(let error): responseErrorFirstPage = error
                promiseFirstPage.fulfill()
            case .success(let characters): responseCharactersFirstPage = characters
                promiseFirstPage.fulfill()
            }
        }
        wait(for: [promiseFirstPage], timeout: 5)
        
        XCTAssertNil(responseErrorFirstPage)
        XCTAssertNotNil(responseCharactersFirstPage)
        
        XCTAssertEqual(responseCharactersFirstPage?.code, 200)
        
        self.characterService = CharacterService(query: .characters(limit: 4, offset: 5))
        self.characterService.fetchCharacterData { result in
            switch result {
            case .failure(let error): responseErrorSecondPage = error
                promiseSecondPage.fulfill()
            case .success(let characters): responseCharactersSecondPage = characters
                promiseSecondPage.fulfill()
            }
        }
        wait(for: [promiseSecondPage], timeout: 5)
        
        XCTAssertNil(responseErrorSecondPage)
        XCTAssertNotNil(responseCharactersSecondPage)
        
        XCTAssertEqual(responseCharactersSecondPage?.code, 200)
        XCTAssertEqual((responseCharactersFirstPage?.data?.offset ?? 0) + (responseCharactersSecondPage?.data?.offset ?? 0), 5)
    }
}
