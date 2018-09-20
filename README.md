# ![UI Testing](/images/icon.png) UI Testing Example

This sample project shows a different approach to writing UI tests that has a number of benefits:

- 👩🏻‍🏫 Easier to read
- 👨🏾‍🔧 Easier to maintain
- 👩🏼‍💻 Easier to write tests first

## Overview
![UI Testing Process](/images/process.png)

When implementing a new feature, ideally, you will follow a three-step process:

1. Write test page objects (see [Test Page](#test-page))
2. Write failing UI tests (see [UI Tests](#ui-tests))
3. Implement feature, making tests pass

## Test Page
![UI Test Page](/images/page.png)

A test page object is typically comprised of three parts:

1. Elements
2. Actions
3. Verifications

These sections represent a screen in your app. The elements are private to the page object, and the actions and verifications are the API surface for UI tests to use in validating the behavior of the app.

An element may look something like:

```swift
fileprivate var table: XCUIElement {
    return app.tables["MasterViewController.tableView"]
}
```

An action is going to return the test page object that is the result of the action, and might look like this:

```swift
@discardableResult func tapOnCell(at index: Int, file: String = #file, line: UInt = #line) -> DetailPage {
    let cell = self.cell(at: index)
    testCase.expect(exists: cell, file: file, line: line)
    cell.tap()
    return DetailPage(testCase: testCase)
}
```

*Note:* We use custom functions instead of `XCTAssert` to make the testing code more readable. View more in [Matchers.swift](/UITestingExampleUITests/Matchers.swift).

Finally, a verification is a function to use in validating the expected state of the app, and may look like this:

```swift
@discardableResult func verifyTableCellCount(is count: Int, file: String = #file, line: UInt = #line) -> MasterPage {
    testCase.expect(exists: table, file: file, line: line)
    testCase.expect(table.cells.count, equals: count, file: file, line: line)
    return self
}
```

## UI Tests
![UI Tests](/images/tests.png)

In the actual UI tests, which are written in a subclass of `XCTestCase`, you will create a test page object, and call various functions on that object. These tests are exceptional readable, and make it much easier to reason about the behavior that you are expecting as users interact with your app.

An example test for verifying an entry can be added and viewed properly may look like this:

```swift
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
```


## Summary
This approach to UI testing has led to significant improvements in our tests and the time it takes to write and maintain them. Hopefully this is helpful to you as well!
