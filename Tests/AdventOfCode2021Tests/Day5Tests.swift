import XCTest
import AdventOfCode2021Library

final class Day5Tests: XCTestCase {
    func testParsesCorrectly() throws {
        let parsedData = try XCTUnwrap(Day5.valuesFor(rawString: .sample))
        XCTAssertEqual(parsedData.first, .init(start: .init(x: 0, y: 9), end: .init(x: 5, y: 9)))
        XCTAssertEqual(parsedData.last, .init(start: .init(x: 5, y: 5), end: .init(x: 8, y: 2)))
    }

    func testPassesSampleCasePart1() throws {
        try XCTAssertEqual(Day5.run(configuration: .part1, with: .rawInput(.sample)), "5")
    }

//    func testPassesSampleCasePart2() throws {
//        try XCTAssertEqual(Day4.run(configuration: .part2, with: .rawInput(.sample)), "1924")
//    }
}

private extension String {
    static let sample = """
    0,9 -> 5,9
    8,0 -> 0,8
    9,4 -> 3,4
    2,2 -> 2,1
    7,0 -> 7,4
    6,4 -> 2,0
    0,9 -> 2,9
    3,4 -> 1,4
    0,0 -> 8,8
    5,5 -> 8,2
    """
}
