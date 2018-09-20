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
        let nowLabel = String(describing: Date())
        
        MasterPage(testCase: self)
            .verifyMasterPageIsShowing()
            .verifyTableCellCount(is: 0)
            .tapOnAddButton()
            .verifyTableCellCount(is: 1)
            .verifyCell(at: 0, hasLabel: nowLabel)
            .tapOnCell(at: 0)
            
            // Detail page
            .verifyDetailPageIsShowing()
            .verifyLabelText(is: nowLabel)
            .tapOnBackButton()
            
            // Master page
            .verifyMasterPageIsShowing()
    }

}
