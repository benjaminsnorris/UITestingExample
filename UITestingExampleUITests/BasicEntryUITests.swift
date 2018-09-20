//
//  BasicEntryUITests.swift
//  UITestingExampleUITests
//
//  Created by Ben Norris on 9/20/18.
//  Copyright © 2018 Ben Norris. All rights reserved.
//

import XCTest

class BasicEntryUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        let application = XCUIApplication()
        application.launchArguments.append("--uitesting")
        application.launch()
    }

    func testAddingEntry() {
        let zeroLabel = "0"
        
        MasterPage(testCase: self)
            .verifyMasterPageIsShowing()
            .verifyTableCellCount(is: 0)
            .tapOnAddButton()
            .verifyTableCellCount(is: 1)
            .verifyCell(at: 0, hasLabel: zeroLabel)
            .tapOnCell(at: 0)
            
            // Detail page
            .verifyDetailPageIsShowing()
            .verifyLabelText(is: zeroLabel)
            .tapOnBackButton()
            
            // Master page
            .verifyMasterPageIsShowing()
    }

}
