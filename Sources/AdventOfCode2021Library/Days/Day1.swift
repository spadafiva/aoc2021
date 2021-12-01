import Foundation
import Parsing

// MARK: Solution
public struct Day1: AdventOfCodeDay {
    public static func result(inputs: [Int], configuration: Configuration) throws -> String {
        var previous: Int? = nil
        var increases = 0

        var cachedDepths: [Int: Int] = [:]
        let lastIndex = inputs.count - configuration.windowSize

        for i in 0...lastIndex {
            let depthSum = cachedDepths[i] ?? {
                let range = i..<(i + configuration.windowSize)
                let values = range.map { inputs[$0] }
                return values.reduce(0, +)
            }()

            cachedDepths[i] = depthSum

            if let previous = previous, previous < depthSum {
                increases += 1
            }
            previous = depthSum
        }

        return "\(increases)"
    }
}

// MARK: Parser
extension Day1 {
    public static let parser = Int.parser()
}

// MARK: Configuration
extension Day1 {
    public struct Configuration: DayConfiguration {
        var windowSize: Int

        public static var part1: Day1.Configuration {
            .init(windowSize: 1)
        }

        public static var part2: Day1.Configuration {
            .init(windowSize: 3)
        }
    }
}
