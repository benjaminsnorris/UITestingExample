//
//  DetailPage.swift
//  UITestingExampleUITests
//
//  Created by Ben Norris on 9/20/18.
//  Copyright © 2018 Ben Norris. All rights reserved.
//

import XCTest

struct DetailPage: TestPage {
    
    let testCase: XCTestCase
    
    
    // MARK: - Elements
    
    fileprivate var detailText: XCUIElement {
        return app.staticTexts["DetailViewController.detailDescriptionLabel"]
    }
    
    fileprivate var backButton: XCUIElement {
        return app.navigationBars.buttons["Master"]
    }

    
    // MARK: - Actions

    @discardableResult func tapOnBackButton(file: String = #file, line: UInt = #line) -> MasterPage {
        testCase.expect(exists: backButton, file: file, line: line)
        backButton.tap()
        return MasterPage(testCase: testCase)
    }
    
    
    // MARK: - Verifications
    
    @discardableResult func verifyDetailPageIsShowing(file: String = #file, line: UInt = #line) -> DetailPage {
        testCase.expect(exists: detailText, file: file, line: line)
        return self
    }
    
    @discardableResult func verifyLabelText(is text: String, file: String = #file, line: UInt = #line) -> DetailPage {
        testCase.expect(exists: detailText, file: file, line: line)
        testCase.expect(detailText.label, equals: text, file: file, line: line)
        return self
    }

}
