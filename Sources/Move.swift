// Wrapping an Array of Cards because it's not possible to (performantly) implement Hashable on Arrays
public struct Move : Hashable, ExpressibleByArrayLiteral {
    public let cards: [Card]
    public let hashValue: Int

    public init(arrayLiteral elements: Card...) {
        self.init(elements)
    }

    public init(_ elements: [Card]) {
        cards = elements
        hashValue = elements.map({ $0.rawValue }).reduce(0, ^)
    }
}

public func ==(lhs: Move, rhs: Move) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

