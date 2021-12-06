import XCTest
import AdventOfCode2021Library

final class Day6Tests: XCTestCase {
    func testParsesCorrectly() throws {
        let parsedData = try XCTUnwrap(Day6.valuesFor(rawString: .sample))
        XCTAssertEqual(parsedData.first, [3, 4, 3, 1, 2])
    }

    func testGrowsCorrectly() {
        try XCTAssertEqual(Day6.run(configuration: .init(iterations: 1), with: .rawInput(.sample)), "5")
        try XCTAssertEqual(Day6.run(configuration: .init(iterations: 2), with: .rawInput(.sample)), "6")
    }

    func testPassesSampleCasePart1() throws {
        try XCTAssertEqual(Day6.run(configuration: .init(iterations: 18), with: .rawInput(.sample)), "26")
        try XCTAssertEqual(Day6.run(configuration: .init(iterations: 80), with: .rawInput(.sample)), "5934")
    }

//    func testPassesSampleCasePart2() throws {
//        try XCTAssertEqual(Day6.run(configuration: .part2, with: .rawInput(.sample)), "345387")
//    }
}

private extension String {
    static let sample = "3,4,3,1,2"
}
