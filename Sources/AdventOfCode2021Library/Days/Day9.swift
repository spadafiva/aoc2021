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
        switch configuration {
        case .part1:
            return part1(input: input, configuration: configuration)
        case .part2:
            return part2(input: input, configuration: configuration)
        }
    }

    // MARK: Part 1
    public static func part1(input: HeatMap<Int>, configuration: PartOnlyConfiguration) -> String {
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

    // MARK: Part 2
    public static func part2(input: HeatMap<Int>, configuration: PartOnlyConfiguration) -> String {
        var basinSizes: [Point: Set<Point>] = [:]

        for yIdx in 0..<input.rows.count {
            for xIdx in 0..<input.rows[yIdx].count {
                let point = Point(x: xIdx, y: yIdx)
                if isLowPoint(point: point, in: input) {
                    let newBasin = findBasinEdges(around: point, in: input, ignoringPoints: [])
                    basinSizes[point] = newBasin
                }
            }
        }

        let result = basinSizes.sorted(by: { $0.value.count > $1.value.count }).prefix(3).reduce(1, { $0 * $1.value.count })

        return "\(result)"
    }

    private static func isLowPoint(point: Point, in heatMap: HeatMap<Int>) -> Bool {
        riskValue(point: point, in: heatMap) != nil
    }

    private static func findBasinEdges(around point: Point, in heatMap: HeatMap<Int>, ignoringPoints: Set<Point>) -> Set<Point> {
        let pointValue = heatMap.value(at: point)!
        let nearbyEdgesAndValues = point.adjacentPoints.compactMap { nearbyPoint in
            heatMap.value(at: nearbyPoint).map { (nearbyPoint, $0) }
        }

        let validNearbyEdges = nearbyEdgesAndValues.filter { nearbyEdgeAndValue in
            let (nearbyEdge, nearbyValue) = nearbyEdgeAndValue
            return !ignoringPoints.contains(nearbyEdge) && nearbyValue < 9 && nearbyValue > pointValue
        }.map(\.0)

        var pointsToIgnore = ignoringPoints.union(validNearbyEdges).union([point])
        var validPoints = Set(validNearbyEdges)

        for nearbyEdge in validNearbyEdges {
            let expandedEdges = findBasinEdges(around: nearbyEdge, in: heatMap, ignoringPoints: pointsToIgnore)
            validPoints.formUnion(expandedEdges)
            pointsToIgnore.formUnion(validPoints)
        }

        return pointsToIgnore
    }
}

