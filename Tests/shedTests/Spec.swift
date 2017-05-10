import Nimble
import XCTest

class Spec: XCTestCase, Nimble.AssertionHandler {
    private var test : String?
    private var function: String?
    private var logString : String = ""
    private var beforeBlock: ((Void) -> Void)?
    private var afterBlock: ((Void) -> Void)?


    // MARK: Fail the test at a specific line:
    func fail(messages: [String], _ file: String, _ line: UInt, _ expected: Bool) {
        self.continueAfterFailure = true
        self.recordFailure(withDescription: self.test ?? "", inFile: file, atLine: line, expected: expected)
        let allMessages = messages.reduce("") { $0 + "\n\t" + $1 }
        self.log("\(self.test) : FAILURE :\(allMessages)", file: file, line: line)
    }

    func assert(_ assertion: Bool, message: Nimble.FailureMessage, location: Nimble.SourceLocation) {
      if !assertion {
        fail(messages: [message.stringValue], location.file.description, location.line, true)
      }
    }

    // MARK: Echo information during the test if verbose is set to true
    var verbose = false
    func log(_ s: @autoclosure () -> String, file: String = #file, line: UInt = #line) {
        let str = s()
        self.logString += "line \(line) : " + str + "\n\n"
        if(self.verbose) {
            print("****** \(file) -- \(line) : \(str)")
        }
    }

    // The Nimble matcher framework calls on an assertion handler.  Set it as
    // self for now:
    var cachedAssertionHandler: Nimble.AssertionHandler!
    override func setUp() {
      cachedAssertionHandler = NimbleAssertionHandler
      NimbleAssertionHandler = self
    }

    // This is overridden from XCTest.  It's called at the end of every method.
    override func tearDown() {
        var str = ""
        str += "\n\n"
        str += "****************************************************************************\n"
        str += "\(#file)\nSummary of call to \(self.function ?? "")\n\n\(self.logString)\n"
        str += "End of summary for call to \(self.function)\n"
        str += "****************************************************************************\n"
        str += "\n\n"

        print(str)

        self.logString = ""
        self.test = ""
        NimbleAssertionHandler = cachedAssertionHandler
    }

    // MARK: Helpers for more rspec-like tests
    func it(_ msg: String, file: String = #file, line: UInt = #line, function: String = #function, block: (Void) -> Void ) {
        self.test = "it \(msg)"
        self.function = function

        self.before()
        if self.beforeBlock != nil { self.beforeBlock!() }

        block()

        if self.afterBlock != nil { self.afterBlock!() }
        self.after()
    }

    // This is run before every it() -- override to set up or configure
    func before() { }

    // Call this to set the before block
    func before(file: String = #file, line: UInt = #line, block: @escaping (Void) -> Void) {
        self.beforeBlock = block
    }

    // Call this to set the before block
    func after(file: String = #file, line: UInt = #line, block: @escaping (Void) -> Void) {
        self.afterBlock = block
    }

    // This is run after every it() -- override to tear down or reset
    func after() { }

}

