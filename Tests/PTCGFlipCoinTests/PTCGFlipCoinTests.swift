import XCTest
@testable import PTCGFlipCoin

final class PTCGFlipCoinTests: XCTestCase {

    func testFlip() {
        XCTAssertEqual(PTCGFlipCoin.flip({
            .heads
        }), .heads)
        XCTAssertEqual(PTCGFlipCoin.flip({
            .tail
        }), .tail)
    }

    func testRepeatWith() {
        var current = 0
        let tailIndex = 2
        XCTAssertEqual(PTCGFlipCoin.repeatWith({
            current += 1
            return current != tailIndex ? .heads : .tail
        }, 3), [.heads, .tail, .heads])
    }

    func testRepeatUntil() {
        var current = 0
        let limit = 5
        XCTAssertEqual(PTCGFlipCoin.repeatUntil({
            current += 1
            return current != limit ? .heads : .tail
        }, .tail), [.heads, .heads, .heads, .heads, .tail])
    }

    static var allTests = [
        ("testFlip", testFlip),
        ("testRepeatWith", testRepeatWith),
        ("testRepeatUntil", testRepeatUntil)
    ]
}
