import Foundation

public struct Day9: AdventOfCodeDay {
    public struct HeatMap<T> {
        var rows: [[T]]

        public init(rows: [[T]]) {
            self.rows = rows
        }

        func value(at point: Point) -> T? {
            guard point.y >= 0,
                  point.y < rows.count,
                  point.x >= 0,
                  point.x < rows[point.y].count
            else {
                return nil
            }
            return rows[point.y][point.x]
        }
    }
    // MARK: Parser
    public static let parseInput: (String) -> HeatMap<Int>? = { input in
        let rowStrings = input.components(separatedBy: .newlines)
        let rows = rowStrings.compactMap { str in
            str.compactMap(\.wholeNumberValue)
        }
        return HeatMap(rows: rows)
    }

    // MARK: Solution
    public static func result(input: HeatMap<Int>, configuration: PartOnlyConfiguration) throws -> String {
        var riskSum = 0

        for yIdx in 0..<input.rows.count {
            for xIdx in 0..<input.rows[yIdx].count {
                if let risk = riskValue(point: .init(x: xIdx, y: yIdx), in: input) {
                    riskSum += risk
                }
            }
        }

        return "\(riskSum)"
    }

    private static func riskValue(point: Point, in heatMap: HeatMap<Int>) -> Int? {
        let value = heatMap.value(at: point)!
        for adjacentPoint in point.adjacentPoints {
            if let adjacentValue = heatMap.value(at: adjacentPoint), adjacentValue <= value {
                return nil
            }
        }
        return value + 1
    }
}

extension Point {
    var adjacentPoints: [Point] {[
        Point(x: x - 1, y: y),
        Point(x: x + 1, y: y),
        Point(x: x, y: y - 1),
        Point(x: x, y: y + 1)
    ]}
}
