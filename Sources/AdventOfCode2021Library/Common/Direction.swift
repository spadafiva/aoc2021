import Parsing

public enum Direction: String, RawRepresentable, Equatable {
    case up
    case down
    case forward
    case backward

    static let parser = Parsers.PrefixUpTo(" ")
        .map(String.init)
        .compactMap(Direction.init(rawValue:))
}
