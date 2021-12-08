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

        for possibleMeetingPoint in minValue...maxValue {
            var meetingPointFuel = 0
            for value in input where meetingPointFuel < maxFuel {
                let movement = abs(value - possibleMeetingPoint)
                meetingPointFuel += movement
            }
            maxFuel = min(maxFuel, meetingPointFuel)
        }

        return "\(maxFuel)"
    }
}
