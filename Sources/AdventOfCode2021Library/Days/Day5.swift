import Foundation
import Parsing

public struct Day5: AdventOfCodeDay {
    // MARK: Configuration
    public typealias Configuration = PartOnlyConfiguration

    // MARK: Input
    public struct DayInput: Equatable {
        public init(start: Point, end: Point) {
            self.start = start
            self.end = end
        }

        public var start: Point
        public var end: Point
    }

    // MARK: Parser
    public static let parser = Point.commaParser
        .skip(" -> ")
        .take(Point.commaParser)
        .map(DayInput.init)

    // MARK: Solution
    public static func result(inputs: [DayInput], configuration: PartOnlyConfiguration) throws -> String {

        var heatMap: [Point: Int] = [:]

        func count(point: Point) {
            let value = heatMap[point] ?? 0
            heatMap[point] = value + 1
        }

        for input in inputs {
            if input.start.x == input.end.x {
                for point in linePoints(a: input.start, b: input.end, along: \.x) {
                    count(point: point)
                }
            } else if input.start.y == input.end.y {
                for point in linePoints(a: input.start, b: input.end, along: \.y) {
                    count(point: point)
                }
            } else if configuration == .part2 {
                for point in diagonalPoints(a: input.start, b: input.end) {
                    count(point: point)
                }
            }
        }

        return "\(heatMap.filter { $0.value >= 2 }.count)"
    }

    private static func linePoints(a: Point, b: Point, along samePath: WritableKeyPath<Point, Int>) -> [Point] {
        let varyingPath: WritableKeyPath<Point, Int> = samePath == \Point.x ? \.y : \.x
        let aStart = a[keyPath: varyingPath]
        let bStart = b[keyPath: varyingPath]
        let range = aStart < bStart ? (aStart...bStart) : (bStart...aStart)
        return range.map {
            var result = Point.zero
            result[keyPath: varyingPath] = $0
            result[keyPath: samePath] = a[keyPath: samePath]
            return result
        }
    }

    private static func diagonalPoints(a: Point, b: Point) -> [Point] {
        let xDiff = a.x < b.x ? 1 : -1
        let yDiff = a.y < b.y ? 1 : -1

        var x = a.x
        var y = a.y

        var result: [Point] = []

        while x != (b.x + xDiff) && y != (b.y + yDiff) {
            result.append(.init(x: x, y: y))
            x += xDiff
            y += yDiff
        }

        return result
    }
}
