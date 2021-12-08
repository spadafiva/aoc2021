import XCTest
import AdventOfCode2021Library

final class Day7Tests: XCTestCase {
    func testPassesSampleCasePart1() throws {
        try XCTAssertEqual(Day7.run(configuration: .part1, with: .rawInput(.sample)), "37")
    }

    func testPassesSampleCasePart2() throws {
//        try XCTAssertEqual(Day6.run(configuration: .part2, with: .rawInput(.sample)), "26984457539")
    }
}

private extension String {
    static let sample = "16,1,2,0,4,2,7,1,2,14"
}
