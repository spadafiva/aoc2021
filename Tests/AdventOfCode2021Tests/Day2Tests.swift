import XCTest
import AdventOfCode2021Library

final class Day2Tests: XCTestCase {
    func testPassesSampleCasePart1() throws {
        try XCTAssertEqual(Day2.run(configuration: .part1, with: .rawInput(.sample)), "150")
    }

    func testPassesSampleCasePart2() throws {
        try XCTAssertEqual(Day2.run(configuration: .part2, with: .rawInput(.sample)), "900")
    }
}

private extension String {
    static let sample = """
    forward 5
    down 5
    forward 8
    up 3
    down 8
    forward 2
    """
}
