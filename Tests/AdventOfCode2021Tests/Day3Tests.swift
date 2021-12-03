import XCTest
import AdventOfCode2021Library

final class Day3Tests: XCTestCase {
    func testParsesInputs() throws {
        try XCTAssertEqual(Day3.valuesFor(rawString: .sample).joined(separator: "\n"), """
            00100
            11110
            10110
            10111
            10101
            01111
            00111
            11100
            10000
            11001
            00010
            01010
            """
        )
    }
    func testPassesSampleCasePart1() throws {
        try XCTAssertEqual(Day3.run(configuration: .part1, with: .rawInput(.sample)), "198")
    }

    func testPassesSampleCasePart2() throws {
        try XCTAssertEqual(Day3.run(configuration: .part2, with: .rawInput(.sample)), "230")
    }
}

private extension String {
    static let sample = """
    00100
    11110
    10110
    10111
    10101
    01111
    00111
    11100
    10000
    11001
    00010
    01010

    """
}
