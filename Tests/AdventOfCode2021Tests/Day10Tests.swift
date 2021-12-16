import XCTest
import AdventOfCode2021Library

final class Day10Tests: XCTestCase {
    func testPassesSampleCasePart1() throws {
        try XCTAssertEqual(Day10.run(configuration: .part1, with: .rawInput(.sample)), "26397")
    }
//
//    func testPassesSampleCasePart2() throws {
//      try XCTAssertEqual(Day7.run(configuration: .part2, with: .rawInput(.sample)), "168")
//    }
}

private extension String {
    static let sample = """
    [({(<(())[]>[[{[]{<()<>>
    [(()[<>])]({[<{<<[]>>(
    {([(<{}[<>[]}>{[]{[(<()>
    (((({<>}<{<{<>}{[]{[]{}
    [[<[([]))<([[{}[[()]]]
    [{[{({}]{}}([{[{{{}}([]
    {<[[]]>}<{[{[{[]{()[[[]
    [<(<(<(<{}))><([]([]()
    <{([([[(<>()){}]>(<<{{
    <{([{{}}[<[[[<>{}]]]>[]]
    """
}
