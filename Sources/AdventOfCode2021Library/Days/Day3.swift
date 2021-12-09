import Foundation
import Parsing

// MARK: Solution
public struct Day3: AdventOfCodeDay {
    public static func result(input: [String], configuration: PartOnlyConfiguration) throws -> String {
        switch configuration {
        case .part1: return try part1(inputs: input, configuration: configuration)
        case .part2: return try part2(inputs: input, configuration: configuration)
        }
    }

    struct RowStatus {
        var zeros: Int = 0
        var ones: Int = 0

        var isEqual: Bool { zeros == ones }
        var hasMoreOnes: Bool { ones > zeros }
        var hasMoreZeros: Bool { zeros < ones }
    }

    static func part1(inputs: [String], configuration: PartOnlyConfiguration) throws -> String {
        let rowStatuses = createRowStatuses(from: inputs)
        let gammaBinary = rowStatuses.map { $0.zeros > $0.ones ? "0" : "1" }.joined()
        let epsilonBinary = rowStatuses.map { $0.zeros < $0.ones ? "0" : "1" }.joined()

        guard let gamma = Int(gammaBinary, radix: 2), let epsilon = Int(epsilonBinary, radix: 2) else {
            struct InvalidBinaryStringsError: Error {}
            throw InvalidBinaryStringsError()
        }

        return "\(gamma * epsilon)"
    }

    static func part2(inputs: [String], configuration: PartOnlyConfiguration) throws -> String {
        let oxygenBinary = searchForValidEvents(from: inputs, currentPosition: 0, matches: { input, rowStatus, currentPosition in
            let value = stringAt(currentPosition, in: input)
            if rowStatus.isEqual || rowStatus.hasMoreOnes {
                return value == "1"
            } else {
                return value == "0"
            }
        })

        let co2Binary = searchForValidEvents(from: inputs, currentPosition: 0, matches: { input, rowStatus, currentPosition in
            let value = stringAt(currentPosition, in: input)
            if rowStatus.isEqual || rowStatus.hasMoreZeros {
                return value == "0"
            } else {
                return value == "1"
            }
        })

        guard let oxygen = Int(oxygenBinary, radix: 2), let co2 = Int(co2Binary, radix: 2) else {
            struct InvalidBinaryStringsError: Error {}
            throw InvalidBinaryStringsError()
        }

        return "\(oxygen * co2)"
    }

    private static func searchForValidEvents(from inputs: [String], currentPosition: Int, matches: (String, RowStatus, Int) -> Bool) -> String {
        let currentRowStatus = createRowStatus(across: inputs, for: currentPosition)
        let validMatches = inputs.filter { matches($0, currentRowStatus, currentPosition) }
        if validMatches.count == 1 {
            return validMatches[0]
        } else {
            return searchForValidEvents(from: validMatches, currentPosition: currentPosition + 1, matches: matches)
        }
    }

    private static func createRowStatuses(from inputs: [String]) -> [RowStatus] {
        guard let length = inputs.first?.count else { return [] }
        return (0..<length).map { createRowStatus(across: inputs, for: $0) }
    }

    private static func createRowStatus(across inputs: [String], for position: Int) -> RowStatus {
        var result = RowStatus()
        for input in inputs {
            if stringAt(position, in: input) == "0" {
                result.zeros += 1
            } else {
                result.ones += 1
            }
        }

        return result
    }

    private static func stringAt(_ pos: Int, in str: String) -> String {
        let index = str.index(str.startIndex, offsetBy: pos)
        return String(str[index])
    }
}

// MARK: Parser
extension Day3 {
    public static let parseInput = DayInputParser.multiline(Parsers.StringLine())
}

// MARK: Configuration
extension Day3 {
    public typealias Configuration = PartOnlyConfiguration
}


extension Parsers {
    static func StringLine() -> AnyParser<Substring, String> {
        PrefixUpTo("\n")
        .map(String.init)
        .eraseToAnyParser()
    }
}
