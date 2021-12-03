import Foundation
import Parsing

// MARK: Solution
public struct Day3: AdventOfCodeDay {
    public typealias DayInput = String
    public static func result(inputs: [DayInput], configuration: PartOnlyConfiguration) throws -> String {
        switch configuration {
        case .part1: return try part1(inputs: inputs, configuration: configuration)
        case .part2: return try part2(inputs: inputs, configuration: configuration)
        }
    }

    static func part1(inputs: [DayInput], configuration: PartOnlyConfiguration) throws -> String {
        var positions: [Int: Int] = [:]

        for row in inputs {
            for (index, digit) in row.enumerated() {
                guard digit == "1" else { continue }
                let newCount = positions[index].map { $0 + 1 } ?? 1
                positions[index] = newCount
            }
        }

        let orderedPositions = positions.sorted(by: { $0.key < $1.key })
        let gammaBinary = calculateGamma(from: orderedPositions, inputCount: inputs.count)
        let epsilonBinary = calculateEpsilon(from: orderedPositions, inputCount: inputs.count)


        guard let gamma = Int(gammaBinary, radix: 2), let epsilon = Int(epsilonBinary, radix: 2) else {
            struct InvalidBinaryStringsError: Error {}
            throw InvalidBinaryStringsError()
        }

        return "\(gamma * epsilon)"
    }

    static func part2(inputs: [DayInput], configuration: PartOnlyConfiguration) throws -> String {
        return "fail"
    }

    private static func calculateGamma(from positions: [Dictionary<Int, Int>.Element], inputCount: Int) -> String {
        positions.map { $0.value > (inputCount / 2) ? "1" : "0" }.joined()
    }

    private static func calculateEpsilon(from positions: [Dictionary<Int, Int>.Element], inputCount: Int) -> String {
        positions.map { $0.value > (inputCount / 2) ? "0" : "1" }.joined()
    }
}

// MARK: Parser
extension Day3 {
    public static let parser = Parsers.StringLine()
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
