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
    associatedtype Configuration: DayConfiguration

    static var parseInput: (String) -> DayInput? { get }

    static func result(input: DayInput, configuration: Configuration) throws -> String
}

enum DayInputParser {
    static func single<DayInputParser: Parser>(_ parser: DayInputParser) -> (String) -> DayInputParser.Output? where DayInputParser.Input == Substring {
        { parser.parse(Substring($0)) }
    }

    static func multiline<DayInputParser: Parser>(_ parser: DayInputParser,  separator: String = "\n") -> (String) -> [DayInputParser.Output]? where DayInputParser.Input == Substring {
        { Many(parser, separator: separator).parse(Substring($0)) }
    }
}

extension AdventOfCodeDay {
    public static func valuesFor(rawString: String) throws -> DayInput {
        guard let results = parseInput(rawString) else {
            throw ParsingError.cannotParse(rawString)
        }
        return results
    }

    static func valuesFor(inputsFile fileName: String) throws -> DayInput {
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
        let input: DayInput

        switch inputSource {
        case let .value(inputValue):
            input = inputValue
        case let .fileName(fileName):
            input = try valuesFor(inputsFile: fileName)
        case let .rawInput(rawInput):
            input = try valuesFor(rawString: rawInput)
        }

        return try result(input: input, configuration: configuration)
    }
}

public enum PartOnlyConfiguration: DayConfiguration {
    case part1
    case part2
}

public enum AdventOfCodeInputSource<T> {
    case value(T)
    case rawInput(String)
    case fileName(String)
}
