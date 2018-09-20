//
//  TestPage.swift
//  UITestingExampleUITests
//
//  Created by Ben Norris on 9/20/18.
//  Copyright © 2018 Ben Norris. All rights reserved.
//

import XCTest

protocol TestPage {
    var testCase: XCTestCase { get }
}


extension TestPage {
    
    var app: XCUIApplication {
        return XCUIApplication()
    }
    
}
