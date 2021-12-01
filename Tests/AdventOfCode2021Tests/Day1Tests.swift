import XCTest
import AdventOfCode2021Library

final class Day1Tests: XCTestCase {
    func testPassesSampleCasePart1() throws {
        try XCTAssertEqual(Day1.run(configuration: .part1, with: .rawInput(.sample)), "7")
    }

    func testPassesSampleCasePart2() throws {
        try XCTAssertEqual(Day1.run(configuration: .part2, with: .rawInput(.sample)), "5")
    }
}

private extension String {
    static let sample = """
    199
    200
    208
    210
    200
    207
    240
    269
    260
    263
    """
}
