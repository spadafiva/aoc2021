import Foundation
import Parsing

// MARK: Solution
public struct Day4: AdventOfCodeDay {
    public struct Board: Equatable {
        public struct Space: Equatable {
            public var value: Int
            public var isMarked: Bool

            public init(value: Int, isMarked: Bool = false) {
                self.value = value
                self.isMarked = isMarked
            }
        }

        public var rows: [[Space]]

        public init(rows: [[Space]]) {
            self.rows = rows
        }

        public mutating func mark(num: Int) {
            for rowIdx in 0..<rows.count {
                for colIdx in 0 ..< rows[rowIdx].count where rows[rowIdx][colIdx].value == num {
                    rows[rowIdx][colIdx].isMarked = true
                }
            }
        }

        public func isWinner() -> Bool {
            for index in 0..<rows.count {
                guard rows[index].contains(where: { !$0.isMarked }) else {
                    return true
                }

                guard rows.map({ $0[index] }).contains(where: { !$0.isMarked }) else {
                    return true
                }
            }
            return false
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
        var input = inputs[0]
        let (boardIdx, position) = try findWinningBoard(input: &input)
        let winningNumber = input.numbers[position]
        let result = calculateScore(winningNumber: winningNumber, board: input.boards[boardIdx])
        return "\(result)"
    }

    static func part2(inputs: [DayInput], configuration: PartOnlyConfiguration) throws -> String {
        var remaining = inputs[0]

        while remaining.boards.count > 1 {
            var input = remaining
            let nextWinner = try findWinningBoard(input: &input)
            remaining.boards.remove(at: nextWinner.boardNumber)
        }

        let winnerInfo = try findWinningBoard(input: &remaining)
        let result = calculateScore(winningNumber: remaining.numbers[winnerInfo.position], board: remaining.boards[0])
        return "\(result)"
    }

    private static func findWinningBoard(input: inout DayInput) throws -> (boardNumber: Int, position: Int) {
        var position = 0

        while position < input.numbers.count {
            if let board = checkForWinner(position: position, input: &input) {
                return (board, position)
            }
            position += 1
        }

        struct InvalidInputError: Error {}
        throw InvalidInputError()
    }

    private static func calculateScore(winningNumber: Int, board: Board) -> Int {
        var total = 0
        for row in board.rows {
            for space in row {
                if !space.isMarked {
                    total += space.value
                }
            }
        }
        return winningNumber * total
    }

    private static func checkForWinner(position: Int, input: inout DayInput) -> Int? {
        let markNumber = input.numbers[position]
        for boardIdx in 0..<input.boards.count {
            input.boards[boardIdx].mark(num: markNumber)
            if input.boards[boardIdx].isWinner() {
                return boardIdx
            }
        }
        return nil
    }
}

extension Day4.Board.Space: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self.init(value: value, isMarked: false)
    }
}

// MARK: Parser
extension Day4 {
    public static let numbersParser = Many(Int.parser(), separator: ",")

    public static let bingoNumber = Parsers.Skip(Parsers.Prefix<Substring> { !$0.isNumber })
        .take(Int.parser())

    public static let bingoRow = Many(bingoNumber, atLeast: 5, atMost: 5, separator: " ")
        .map { $0.map { Board.Space.init(value: $0) } }
    public static let bingoCard = Many(bingoRow, atLeast: 5, atMost: 5, separator: "\n")
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

