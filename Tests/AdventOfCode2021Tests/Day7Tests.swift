import XCTest
import AdventOfCode2021Library

final class Day9Tests: XCTestCase {
    func testPassesSampleCasePart1() throws {
        try XCTAssertEqual(Day9.run(configuration: .part1, with: .rawInput(.sample)), "15")
    }

    func testPassesSampleCasePart2() throws {
      try XCTAssertEqual(Day9.run(configuration: .part2, with: .rawInput(.sample)), "1134")
    }
}

private extension String {
    static let sample = """
    2199943210
    3987894921
    9856789892
    8767896789
    9899965678
    """
}
