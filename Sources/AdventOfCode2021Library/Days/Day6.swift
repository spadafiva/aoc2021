import Foundation
import Parsing

public struct Day6: AdventOfCodeDay {
    // MARK: Configuration
    public struct Configuration: DayConfiguration, ExpressibleByIntegerLiteral {
        public var iterations: Int

        public init(iterations: Int) {
            self.iterations = iterations
        }

        public init(integerLiteral value: IntegerLiteralType) {
            self.init(iterations: value)
        }

        public static let part1 = Configuration(iterations: 80)
        public static let part2 = Configuration(iterations: 256)
    }

    // MARK: Input
    public typealias DayInput = [Int]

    // MARK: Parser
    public static let parser = Many(Int.parser(), separator: ",")
        .eraseToAnyParser()

    // MARK: Solution
    public static func result(inputs: [DayInput], configuration: Configuration) throws -> String {
        var cache: [FishStepCacheHit: Int] = [:]
        let result = inputs[0].reduce(0, { $0 + calculate(fish: $1, steps: configuration.iterations, cache: &cache) })
        return "\(result)"
    }

    private struct FishStepCacheHit: Hashable {
        var fish: Int
        var steps: Int
    }

    private static func calculate(fish: Int, steps: Int, cache: inout [FishStepCacheHit: Int]) -> Int {

        if let cacheHit = cache[.init(fish: fish, steps: steps)] {
            return cacheHit
        }

        guard steps > 0 else {
            cache[.init(fish: fish, steps: steps)] = 0
            return 0
        }

        guard fish < steps else {
            cache[.init(fish: fish, steps: steps)] = 1
            return 1
        }

        let result = calculate(fish: 9, steps: steps - fish, cache: &cache) + calculate(fish: 7, steps: steps - fish, cache: &cache)
        cache[.init(fish: fish, steps: steps)] = result
        return result
    }
}
