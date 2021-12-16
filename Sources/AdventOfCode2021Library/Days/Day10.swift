
import Foundation

public struct Day10: AdventOfCodeDay {
    // MARK: Parser
    public static let parseInput: (String) -> [String]? = { $0.components(separatedBy: .newlines) }

    // MARK: Solution
    public static func result(input: [String], configuration: PartOnlyConfiguration) throws -> String {

        let parseResults = input.map(lineParseResult(for:))

        switch configuration {
        case .part1:
            return "\(countFailureScore(lineResults: parseResults))"
        case .part2:
            let autocompletes: [[TokenType]] = parseResults.compactMap {
                switch $0 {
                case .corrupted:
                    return nil
                case let .incomplete(openTokens: tokens):
                    return tokens
                }
            }
            return "\(middleAutocompleteScore(autocompletes: autocompletes))"
        }
    }

    private static func countFailureScore(lineResults: [LineParseResult]) -> Int {
        lineResults.reduce(0, { total, result in
            switch result {
            case let .corrupted(invalidToken: token):
                return total + token.syntaxPoints
            case .incomplete:
                return total
            }
        })
    }

    private static func middleAutocompleteScore(autocompletes: [[TokenType]]) -> Int {
        let scores = autocompletes.map(score(autocomplete:)).sorted()
        return scores[scores.count / 2]
    }

    private static func score(autocomplete: [TokenType]) -> Int {
        var score = 0

        for token in autocomplete.reversed() {
            score *= 5
            score += token.autocompletePoints
        }

        return score
    }

    enum TokenType: CaseIterable {
        case paren
        case square
        case angle
        case curly

        var open: Character {
            switch self {
            case .paren: return "("
            case .square: return "["
            case .angle: return "<"
            case .curly: return "{"
            }
        }

        var close: Character {
            switch self {
            case .paren: return ")"
            case .square: return "]"
            case .angle: return ">"
            case .curly: return "}"
            }
        }

        var syntaxPoints: Int {
            switch self {
            case .paren: return 3
            case .square: return 57
            case .curly: return 1197
            case .angle: return 25137
            }
        }

        var autocompletePoints: Int {
            switch self {
            case .paren: return 1
            case .square: return 2
            case .curly: return 3
            case .angle: return 4
            }
        }
    }

    private enum LineParseResult {
        case corrupted(invalidToken: TokenType)
        case incomplete(openTokens: [TokenType])
    }

    private static func lineParseResult(for line: String) -> LineParseResult {
        var openTokens: [TokenType] = []
        var currentIndex = line.startIndex

        while currentIndex < line.endIndex {
            let next = line[currentIndex]

            if let openChar = TokenType.allCases.first(where: { $0.open == next }) {
                openTokens.append(openChar)
            } else if let closeChar = TokenType.allCases.first(where: { $0.close == next }) {

                if closeChar == openTokens.last {
                    openTokens.removeLast()
                } else {
                    return .corrupted(invalidToken: closeChar)
                }
            }
            currentIndex = line.index(after: currentIndex)
        }
        return .incomplete(openTokens: openTokens)
    }
}

