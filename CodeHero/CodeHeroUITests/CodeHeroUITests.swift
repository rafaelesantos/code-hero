//
//  CodeHeroUITests.swift
//  CodeHeroUITests
//
//  Created by Rafael Escaleira on 15/07/21.
//

import XCTest

class CodeHeroUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    
    func testFindSpiderMan() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.navigationBars["Characters"].searchFields["Search"].tap()
        app.navigationBars["Characters"].searchFields["Search"].typeText("Spider-man")
        
        let tablesQuery2 = app.tables
        tablesQuery2.cells.containing(.staticText, identifier:"SPIDER-MAN (2099)").element.tap()
        
        let tablesQuery = tablesQuery2
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["2099 Unlimited (1993) #3"].swipeUp()/*[[".cells.staticTexts[\"2099 Unlimited (1993) #3\"]",".swipeUp()",".swipeLeft()",".staticTexts[\"2099 Unlimited (1993) #3\"]"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,1]]@END_MENU_TOKEN@*/
        app.buttons["BACK TO CHARACTERS"]/*@START_MENU_TOKEN@*/.tap()/*[[".tap()",".press(forDuration: 1.1);"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
    }
    
    func testSwitchPage() throws {
        let app = XCUIApplication()
        app.launch()
        app.buttons["go right"].tap()
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
