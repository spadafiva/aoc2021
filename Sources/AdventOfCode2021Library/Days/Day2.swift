import Foundation
import Parsing

// MARK: Solution
public struct Day2: AdventOfCodeDay {
    public struct Command: Equatable {
        public var direction: Direction
        public var amount: Int

        public init(direction: Direction, amount: Int) {
            self.direction = direction
            self.amount = amount
        }
    }

    public static func result(inputs: [Command], configuration: PartOnlyConfiguration) throws -> String {
        switch configuration {
        case .part1: return try part1(inputs: inputs, configuration: configuration)
        case .part2: return try part2(inputs: inputs, configuration: configuration)
        }
    }

    static func part1(inputs: [Command], configuration: PartOnlyConfiguration) throws -> String {
        var depth = 0
        var horizontal = 0

        inputs.forEach { command in
            switch command.direction {
            case .backward:
                horizontal -= command.amount
            case .up:
                depth -= command.amount
            case .down:
                depth += command.amount
            case .forward:
                horizontal += command.amount
            }
        }

        return "\(depth * horizontal)"
    }

    static func part2(inputs: [Command], configuration: PartOnlyConfiguration) throws -> String {
        var depth = 0
        var horizontal = 0
        var aim = 0

        inputs.forEach { command in
            switch command.direction {
            case .backward:
                break // No backward inputs
            case .up:
                aim -= command.amount
            case .down:
                aim += command.amount
            case .forward:
                horizontal += command.amount
                depth += (command.amount * aim)
            }
        }

        return "\(depth * horizontal)"
    }
}

// MARK: Parser
extension Day2 {
    public static let parser = Direction.parser
        .skip(" ")
        .take(Int.parser())
        .map(Command.init)
}

// MARK: Configuration
extension Day2 {
    public typealias Configuration = PartOnlyConfiguration
}
