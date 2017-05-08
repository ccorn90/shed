import XCTest
import Quick
@testable import shedTests

XCTMain([
    testCase(shedTests.allTests),
])

Quick.QCKMain([
    PlaysSpec.self,
])
