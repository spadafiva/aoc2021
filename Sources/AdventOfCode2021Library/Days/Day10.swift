
import Foundation

public struct Day10: AdventOfCodeDay {
    // MARK: Parser
    public static let parseInput: (String) -> [String]? = { $0.components(separatedBy: .newlines) }

    // MARK: Solution
    public static func result(input: [String], configuration: PartOnlyConfiguration) throws -> String {
        var invalidInputs: [TokenType] = []

        for line in input {
            if let failingItem = firstFailingItem(in: line) {
                invalidInputs.append(failingItem)
            }
        }

        let score = invalidInputs.reduce(0, { $0 + $1.points })

        return "\(score)"
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

        var points: Int {
            switch self {
            case .paren: return 3
            case .square: return 57
            case .curly: return 1197
            case .angle: return 25137
            }
        }
    }


    private static func firstFailingItem(in line: String) -> TokenType? {
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
                    return closeChar
                }
            }
            currentIndex = line.index(after: currentIndex)
        }
        return nil
    }
}

