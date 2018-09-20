//
//  UITestingExampleUITests.swift
//  UITestingExampleUITests
//
//  Created by Ben Norris on 9/18/18.
//  Copyright © 2018 Ben Norris. All rights reserved.
//

import Foundation
import XCTest

private enum Keys {
    static let id = "id"
}

extension XCTestCase {
    
    // MARK: - Throws
    func shouldNotThrow(file: String = #file, line: UInt = #line, _ block: () throws -> Void) {
        do {
            _ = try block()
        } catch {
            recordFailure(withDescription: "Boo! \(error)", inFile: file, atLine: Int(line), expected: true)
        }
    }
    
    func shouldThrow(file: String = #file, line: UInt = #line, _ block: () throws -> Void) {
        do {
            _ = try block()
            recordFailure(withDescription: "Should have thrown!", inFile: file, atLine: Int(line), expected: true)
        } catch {
        }
    }
    
    
    // MARK: - Equals
    func expect(nil expression: @autoclosure () -> Any?, file: String = #file, line: UInt = #line) {
        if let it = expression() {
            recordFailure(withDescription: "Expected '\(it)' to be nil.", inFile: file, atLine: Int(line), expected: true)
        }
    }
    
    func expect(notNil expression: @autoclosure () -> Any?, file: String = #file, line: UInt = #line) {
        if expression() == nil {
            recordFailure(withDescription: "Expected this not to be nil.", inFile: file, atLine: Int(line), expected: true)
        }
    }
    
    func expect(exists element: XCUIElement, file: String = #file, line: UInt = #line) {
        if !element.exists {
            recordFailure(withDescription: "Expected \(element) to exist.", inFile: file, atLine: Int(line), expected: true)
        }
    }
    
    func expect(doesNotExist element: XCUIElement, file: String = #file, line: UInt = #line) {
        if element.exists {
            recordFailure(withDescription: "Expected \(element) to not exist.", inFile: file, atLine: Int(line), expected: true)
        }
    }
    
    func expect(false expression: @autoclosure () -> Bool?, file: String = #file, line: UInt = #line) {
        guard let actual = expression() else {
            recordFailure(withDescription: "Expected 'nil' to be false.", inFile: file, atLine: Int(line), expected: true)
            return
        }
        if actual != false {
            recordFailure(withDescription: "Expected this to be false.", inFile: file, atLine: Int(line), expected: true)
        }
    }
    
    func expect(true expression: @autoclosure () -> Bool?, file: String = #file, line: UInt = #line) {
        guard let actual = expression() else {
            recordFailure(withDescription: "Expected 'nil' to be true.", inFile: file, atLine: Int(line), expected: true)
            return
        }
        if actual != true {
            recordFailure(withDescription: "Expected this to be true.", inFile: file, atLine: Int(line), expected: true)
        }
    }
    
    func expect<T: Equatable>(_ this: @autoclosure () -> T?, equals expression: @autoclosure () -> T?, file: String = #file, line: UInt = #line) {
        let actual = this()
        let expected = expression()
        if !equals(actual, expected) {
            recordFailure(withDescription: "Expected '\(String(describing: actual))' to equal '\(String(describing: expected))]", inFile: file, atLine: Int(line), expected: true)
        }
    }
    
    func expect<T: Equatable>(_ this: @autoclosure () -> T?, notEquals expression: @autoclosure () -> T?, file: String = #file, line: UInt = #line) {
        let actual = this()
        let expected = expression()
        if equals(actual, expected) {
            recordFailure(withDescription: "Expected '\(String(describing: actual))' to not equal '\(String(describing: expected))]", inFile: file, atLine: Int(line), expected: true)
        }
    }
    
    func expect(date thisDate: Date?, equals thatDate: Date?, downToThe component: Calendar.Component = .second, file: String = #file, line: UInt = #line) {
        guard let thisDate = thisDate, let thatDate = thatDate else {
            recordFailure(withDescription: "Expected dates to not be nil", inFile: file, atLine: Int(line), expected: true)
            return
        }
        if !Calendar.current.isDate(thisDate, equalTo: thatDate, toGranularity: component) {
            recordFailure(withDescription: "Expected \(thisDate) to equal: \(thatDate)", inFile: file, atLine: Int(line), expected: true)
        }
    }
    
    
    // MARK: - Contains
    func expect(_ actual: String, contains expected: String..., file: String = #file, line: UInt = #line) {
        let result = expected.map { actual.contains($0) }
        if let index = result.index(of: false) {
            recordFailure(withDescription: "Expected \(actual) to contain \(expected[index])", inFile: file, atLine: Int(line), expected: true)
        }
    }
    
    func expect(_ actual: String, doesNotContain expected: String..., file: String = #file, line: UInt = #line) {
        let result = expected.map { actual.contains($0) }
        if let index = result.index(of: true) {
            recordFailure(withDescription: "Expected \(actual) to not contain \(expected[index])", inFile: file, atLine: Int(line), expected: true)
        }
    }
    
    
    // MARK: - Async
    typealias AsyncExecution = () -> Void
    fileprivate static var defaultTimeout: TimeInterval { return 5.0 }
    
    func async(description: String = "Waiting", _ block: (AsyncExecution) -> Void) {
        let waiter = expectation(description: description)
        block {
            waiter.fulfill()
        }
        wait(for: [waiter], timeout: 5)
    }
    
    func expectEventually(nil expression: @autoclosure @escaping () -> Any?, timeout: TimeInterval = XCTestCase.defaultTimeout, file: String = #file, line: UInt = #line) {
        let expected = expectation { () -> Bool in
            return expression() == nil
        }
        
        wait(for: "this", toEventually: "be nil", timeout: timeout, with: [expected], file: file, line: line)
    }
    
    func expectEventually(notNil expression: @autoclosure @escaping () -> Any?, timeout: TimeInterval = XCTestCase.defaultTimeout, file: String = #file, line: UInt = #line) {
        let expected = expectation { () -> Bool in
            return expression() != nil
        }
        
        wait(for: "this", toEventually: "not be nil", timeout: timeout, with: [expected], file: file, line: line)
    }
    
    func expectEventually(exists element: XCUIElement, timeout: TimeInterval = XCTestCase.defaultTimeout, file: String = #file, line: UInt = #line) {
        let expected = expectation { () -> Bool in
            return element.exists
        }
        
        wait(for: element.description, toEventually: "exist", timeout: timeout, with: [expected], file: file, line: line)
    }
    
    func expectEventually(doesNotExist element: XCUIElement, timeout: TimeInterval = XCTestCase.defaultTimeout, file: String = #file, line: UInt = #line) {
        let expected = expectation { () -> Bool in
            return !element.exists
        }
        
        wait(for: element.description, toEventually: "not exist", timeout: timeout, with: [expected], file: file, line: line)
    }
    
    func expectEventually(false expression: @autoclosure @escaping () -> Bool, timeout: TimeInterval = XCTestCase.defaultTimeout, file: String = #file, line: UInt = #line) {
        let expected = expectation { () -> Bool in
            return expression() == false
        }
        
        wait(for: "this", toEventually: "be false", timeout: timeout, with: [expected], file: file, line: line)
    }
    
    func expectEventually(true expression: @autoclosure @escaping () -> Bool, timeout: TimeInterval = XCTestCase.defaultTimeout, file: String = #file, line: UInt = #line) {
        let expected = expectation { () -> Bool in
            return expression() == true
        }
        
        wait(for: "this", toEventually: "be true", timeout: timeout, with: [expected], file: file, line: line)
    }
    
    func expectEventually<T: Equatable>(_ this: @autoclosure @escaping () -> T, equals expression: @autoclosure @escaping () -> T, timeout: TimeInterval = XCTestCase.defaultTimeout, file: String = #file, line: UInt = #line) {
        var lastActual = this()
        var lastExpected = expression()
        guard lastActual != lastExpected else { return }
        
        let expected = expectation { () -> Bool in
            lastActual = this()
            lastExpected = expression()
            return lastActual == lastExpected
        }
        
        wait(for: "'\(lastActual)'", toEventually: "equal '\(lastExpected)'", timeout: timeout, with: [expected], file: file, line: line)
    }
    
    func expectEventually<T: Equatable>(_ this: @autoclosure @escaping () -> T?, equals expression: @autoclosure @escaping () -> T, timeout: TimeInterval = XCTestCase.defaultTimeout, file: String = #file, line: UInt = #line) {
        var lastActual = this()
        var lastExpected = expression()
        guard let actual = lastActual, actual == lastExpected else { return }
        
        let expected = expectation { () -> Bool in
            lastActual = this()
            lastExpected = expression()
            guard let actual = lastActual else { return false }
            return actual == lastExpected
        }
        
        let actualString = (lastActual == nil) ? "nil" : "\(lastActual!)"
        wait(for: "'\(actualString)'", toEventually: "equal '\(lastExpected)'", timeout: timeout, with: [expected], file: file, line: line)
    }
    
    private func equals<T: Equatable>(_ lhs: T?, _ rhs: T?) -> Bool {
        if lhs == nil && rhs == nil {
            return true
        }
        guard let actual = lhs, let expected = rhs else {
            return false
        }
        return actual == expected
    }
    
    private func expectation(from block: @escaping () -> Bool) -> XCTestExpectation {
        let predicate = NSPredicate { _, _ -> Bool in
            return block()
        }
        let expected = expectation(for: predicate, evaluatedWith: NSObject())
        return expected
    }
    
    private func wait(for subject: String, toEventually outcome: String, timeout: TimeInterval, with expectations: [XCTestExpectation], file: String, line: UInt) {
        let result = XCTWaiter().wait(for: expectations, timeout: timeout)
        
        switch result {
        case .completed:
            return
        case .timedOut:
            self.recordFailure(withDescription: "Expected \(subject) to eventually \(outcome). Timed out after \(timeout)s.", inFile: file, atLine: Int(line), expected: true)
        default:
            self.recordFailure(withDescription: "Unexpected result while waiting for \(subject) to eventually \(outcome): \(result)", inFile: file, atLine: Int(line), expected: false)
        }
    }
    
}
