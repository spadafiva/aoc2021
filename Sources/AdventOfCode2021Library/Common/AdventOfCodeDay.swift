//
//  Created by Joe Spadafora on 12/1/21.
//

import Foundation
import Parsing

enum ParsingError: Error {
    case noFile
    case invalidContents(file: URL)
    case cannotParse(String)
}

public protocol DayConfiguration {
    static var part1: Self { get }
    static var part2: Self { get }
}

public protocol AdventOfCodeDay {
    associatedtype DayInput
    associatedtype DayInputParser: Parser where DayInputParser.Input == Substring, DayInputParser.Output == DayInput
    associatedtype Configuration: DayConfiguration

    static var parser: DayInputParser { get }
    static var separator: String { get }

    static func result(inputs: [DayInput], configuration: Configuration) throws -> String
}

extension AdventOfCodeDay {
    public static var separator: String { "\n" }

    public static func valuesFor(rawString: String) throws -> [DayInput] {
        let lineParser = Many(Self.parser, separator: separator)

        guard let result = lineParser.parse(Substring(rawString)).output else {
            throw ParsingError.cannotParse(rawString)
        }

        let compacted = result.compactMap { $0 }

        guard compacted.count == result.count else {
            throw ParsingError.cannotParse(rawString)
        }

        return compacted
    }

    static func valuesFor(inputsFile fileName: String) throws -> [DayInput] {
        guard let url = Bundle.module.url(forResource: fileName, withExtension: "txt") else {
            throw ParsingError.noFile
        }
        guard let text = try? String(contentsOf: url, encoding: .utf8) else {
            throw ParsingError.invalidContents(file: url)
        }

        return try valuesFor(rawString: text)
    }
}

public extension AdventOfCodeDay {
    static func run(configuration: Configuration, with inputSource: AdventOfCodeInputSource<DayInput>) throws -> String {
        let values: [DayInput]

        switch inputSource {
        case let .values(inputValues):
            values = inputValues
        case let .fileName(fileName):
            values = try valuesFor(inputsFile: fileName)
        case let .rawInput(rawInput):
            values = try valuesFor(rawString: rawInput)
        }

        return try result(inputs: values, configuration: configuration)
    }
}

public enum PartOnlyConfiguration: DayConfiguration {
    case part1
    case part2
}

public enum AdventOfCodeInputSource<T> {
    case values([T])
    case rawInput(String)
    case fileName(String)
}
