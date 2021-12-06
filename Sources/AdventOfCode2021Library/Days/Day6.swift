import Foundation
import Parsing

public struct Day6: AdventOfCodeDay {
    // MARK: Configuration
    public struct Configuration: DayConfiguration {
        public var iterations: Int

        public init(iterations: Int) {
            self.iterations = iterations
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
        var fish = inputs[0]
        advance(fish: &fish, turnsRemaining: configuration.iterations)
        return "\(fish.count)"
    }

    private static func advance(fish: inout [Int], turnsRemaining: Int) {
        guard turnsRemaining > 0 else { return }
        var newFish: [Int] = []
        for idx in 0..<fish.count {
            if fish[idx] == 0 {
                fish[idx] = 6
                newFish.append(8)
            } else {
                fish[idx] -= 1
            }
        }
        fish.append(contentsOf: newFish)
        advance(fish: &fish, turnsRemaining: turnsRemaining - 1)
    }
}
