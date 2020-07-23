import XCTest
@testable import CocoaLumberjackAdapter

final class CocoaLumberjackAdapterTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(CocoaLumberjackAdapter().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
