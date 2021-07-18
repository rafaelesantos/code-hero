//
//  CodeHeroPaginationTests.swift
//  CodeHeroPaginationTests
//
//  Created by Rafael Escaleira on 18/07/21.
//

import XCTest
@testable import CodeHeroPagination

class CodeHeroPaginationTests: XCTestCase {
    var sut: PaginationView!

    override func setUpWithError() throws {
        try super.setUpWithError()
        self.sut = PaginationView()
    }

    override func tearDownWithError() throws {
        self.sut = nil
        try super.tearDownWithError()
    }

    func testNextPage() throws {
        self.sut.maxOffset = 1000
        self.sut.setCurrentOffset(1)
        
        for i in 1...self.sut.maxOffset {
            XCTAssertEqual(self.sut.currentOffset, i)
            self.sut.nextButtonHandler(self.sut.rightButton)
            XCTAssertEqual(self.sut.currentOffset, i + 1 > self.sut.maxOffset ? 1 : i + 1)
        }
    }
    
    func testPrevPage() throws {
        self.sut.maxOffset = 1000
        self.sut.setCurrentOffset(1000)
        
        for i in stride(from: self.sut.maxOffset, through: 1, by: -1) {
            XCTAssertEqual(self.sut.currentOffset, i)
            self.sut.prevButtonHandler(self.sut.rightButton)
            XCTAssertEqual(self.sut.currentOffset, i - 1 < 1 ? self.sut.maxOffset : i - 1)
        }
    }
}
