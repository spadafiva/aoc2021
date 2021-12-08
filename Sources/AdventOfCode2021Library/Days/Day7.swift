import Foundation
import Parsing

public struct Day7: AdventOfCodeDay {

    // MARK: Input
    public typealias DayInput = [Int]

    // MARK: Parser
    public static let parser = Many(Int.parser(), separator: ",")
        .eraseToAnyParser()

    // MARK: Solution
    public static func result(inputs: [DayInput], configuration: PartOnlyConfiguration) throws -> String {
        let input = inputs[0]
        var minValue = input[0]
        var maxValue = input[0]
        for value in input {
            minValue = min(minValue, value)
            maxValue = max(maxValue, value)
        }

        var maxFuel = Int.max
        var cache: [Int: Int] = [:]

        for possibleMeetingPoint in minValue...maxValue {
            var meetingPointFuel = 0
            for value in input where meetingPointFuel < maxFuel {
                let movement: Int
                switch configuration {
                case .part1:
                    movement = calculateFlatDistance(value, b: possibleMeetingPoint)
                case .part2:
                    movement = calculateVariableDistance(value, b: possibleMeetingPoint, cache: &cache)
                }
                meetingPointFuel += movement
            }
            maxFuel = min(maxFuel, meetingPointFuel)
        }

        return "\(maxFuel)"
    }

    private static func calculateFlatDistance(_ a: Int, b: Int) -> Int {
        abs(a - b)
    }

    private static func calculateVariableDistance(_ a: Int, b: Int, cache: inout [Int: Int]) -> Int {
        let distance = calculateFlatDistance(a, b: b)
        if let cachedDistance = cache[distance] {
            return cachedDistance
        } else if distance == 0 {
            return 0
        } else {
            let result = distance + calculateVariableDistance(0, b: distance - 1, cache: &cache)
            cache[distance] = result
            return result
        }
    }
}
