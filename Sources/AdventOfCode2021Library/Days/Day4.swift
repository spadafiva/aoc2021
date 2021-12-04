import Foundation
import Parsing

// MARK: Solution
public struct Day4: AdventOfCodeDay {
    public struct Board: Equatable {
        public var rows: [[Int]]

        public init(rows: [[Int]]) {
            self.rows = rows
        }
    }

    public struct DayInput: Equatable {
        public var numbers: [Int]
        public var boards: [Board]

        public init(numbers: [Int], boards: [Day4.Board]) {
            self.numbers = numbers
            self.boards = boards
        }
    }

    public static func result(inputs: [DayInput], configuration: PartOnlyConfiguration) throws -> String {
        switch configuration {
        case .part1: return try part1(inputs: inputs, configuration: configuration)
        case .part2: return try part2(inputs: inputs, configuration: configuration)
        }
    }

    static func part1(inputs: [DayInput], configuration: PartOnlyConfiguration) throws -> String {
        ""
    }

    static func part2(inputs: [DayInput], configuration: PartOnlyConfiguration) throws -> String {
        ""
    }
}

// MARK: Parser
extension Day4 {
    public static let numbersParser = Many(Int.parser(), separator: ",")

    public static let bingoNumber = Parsers.Skip(Parsers.Prefix<Substring> { !$0.isNumber })
        .take(Int.parser())

    public static let bingoRow = Many(bingoNumber, atMost: 5, separator: " ")
    public static let bingoCard = Many(bingoRow, atMost: 5, separator: "\n")
        .map { Board(rows: $0) }
    public static let bingos = Many(bingoCard, separator: "\n")

    public static let parser = numbersParser
        .skip("\n")
        .take(bingos)
        .map(DayInput.init)
        .eraseToAnyParser()
}

// MARK: Configuration
extension Day4 {
    public typealias Configuration = PartOnlyConfiguration
}

