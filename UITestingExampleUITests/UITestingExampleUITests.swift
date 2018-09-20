//
//  UITestingExampleUITests.swift
//  UITestingExampleUITests
//
//  Created by Ben Norris on 9/18/18.
//  Copyright © 2018 Ben Norris. All rights reserved.
//

import XCTest

class UITestingExampleUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        let table = app.tables.firstMatch
        let addButton = app.navigationBars["Master"].buttons["Add"]
        
        XCTAssertEqual(table.cells.count, 0)
        addButton.tap()
        XCTAssertEqual(table.cells.count, 1)

        let firstCell = table.cells.element(boundBy: 0)
        let element = firstCell.label
        firstCell.tap()
        
        let detailNavBar = app.navigationBars["Detail"]
        XCTAssertTrue(detailNavBar.exists)
        let detailDescriptionLabel = app.staticTexts["DetailViewController.detailDescriptionLabel"]
        XCTAssertTrue(detailDescriptionLabel.exists)
        XCTAssertEqual(detailDescriptionLabel.label, element)
        
        detailNavBar.buttons["Master"].tap()
        XCTAssertTrue(addButton.exists)
    }

}
