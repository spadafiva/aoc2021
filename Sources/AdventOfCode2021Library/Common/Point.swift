import Parsing

public struct Point: Hashable, AdditiveArithmetic {
    public var x: Int
    public var y: Int

    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }

    public static let zero = Point(x: 0, y: 0)

    public static func + (lhs: Point, rhs: Point) -> Point {
        Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    public static func - (lhs: Point, rhs: Point) -> Point {
        Point(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
}

extension Point {
    static let commaParser = Int.parser()
        .skip(",")
        .take(Int.parser())
        .map(Point.init)
        .eraseToAnyParser()
}

extension Point {
    var adjacentPoints: [Point] {[
        Point(x: x - 1, y: y),
        Point(x: x + 1, y: y),
        Point(x: x, y: y - 1),
        Point(x: x, y: y + 1)
    ]}
}
