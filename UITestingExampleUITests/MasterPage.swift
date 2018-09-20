//
//  MasterPage.swift
//  UITestingExampleUITests
//
//  Created by Ben Norris on 9/20/18.
//  Copyright © 2018 Ben Norris. All rights reserved.
//

import XCTest

struct MasterPage: TestPage {
    
    let testCase: XCTestCase

    
    // MARK: - Elements
    
    fileprivate var addButton: XCUIElement {
        return app.navigationBars.buttons["MasterViewController.addButton"]
    }
    
    fileprivate var table: XCUIElement {
        return app.tables["MasterViewController.tableView"]
    }
    
    fileprivate func cell(at index: Int) -> XCUIElement {
        return table.cells.element(boundBy: index)
    }
    
    fileprivate func deleteButton(for cell: XCUIElement) -> XCUIElement {
        return cell.buttons["Delete"]
    }

    
    // MARK: - Actions
    
    @discardableResult func tapOnAddButton(file: String = #file, line: UInt = #line) -> MasterPage {
        testCase.expect(exists: addButton, file: file, line: line)
        addButton.tap()
        return self
    }
    
    @discardableResult func tapOnCell(at index: Int, file: String = #file, line: UInt = #line) -> DetailPage {
        let cell = self.cell(at: index)
        testCase.expect(exists: cell, file: file, line: line)
        cell.tap()
        return DetailPage(testCase: testCase)
    }
    
    @discardableResult func deleteCell(at index: Int, file: String = #file, line: UInt = #line) -> MasterPage {
        let cell = self.cell(at: index)
        testCase.expect(exists: cell, file: file, line: line)
        cell.swipeLeft()
        let deleteButton = self.deleteButton(for: cell)
        testCase.expect(exists: deleteButton, file: file, line: line)
        deleteButton.tap()
        return self
    }
    
    
    // MARK: - Verifications
    
    @discardableResult func verifyMasterPageIsShowing(file: String = #file, line: UInt = #line) -> MasterPage {
        testCase.expect(exists: table, file: file, line: line)
        return self
    }
    
    @discardableResult func verifyTableCellCount(is count: Int, file: String = #file, line: UInt = #line) -> MasterPage {
        testCase.expect(exists: table, file: file, line: line)
        testCase.expect(table.cells.count, equals: count, file: file, line: line)
        return self
    }
    
    @discardableResult func verifyCell(at index: Int, hasLabel text: String, file: String = #file, line: UInt = #line) -> MasterPage {
        let cell = self.cell(at: index)
        testCase.expect(exists: cell, file: file, line: line)
        testCase.expect(cell.label, equals: text, file: file, line: line)
        return self
    }
    
}
