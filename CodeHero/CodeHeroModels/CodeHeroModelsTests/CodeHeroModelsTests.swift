//
//  CodeHeroModelsTests.swift
//  CodeHeroModelsTests
//
//  Created by Rafael Escaleira on 17/07/21.
//

import XCTest
@testable import CodeHeroModels

class CodeHeroModelsTests: XCTestCase {
    var sut: Character?

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        self.sut = nil
        try super.tearDownWithError()
    }

    func testCharactersParse() throws {
        self.sut = Parser.get("characters")
        
        XCTAssertNotNil(self.sut)
        XCTAssertEqual(self.sut?.code, 200)
        XCTAssertTrue(!(self.sut?.data?.results?.isEmpty ?? true))
        XCTAssertTrue(!(self.sut?.data?.results?.first?.comics?.items?.isEmpty ?? true))
    }
}
