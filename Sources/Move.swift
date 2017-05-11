// Wrapping an Array of Cards because it's not possible to make an Array of
// cards Hashable in a way that satisfies both Swift and the constraints of
// the design, namely that [10, 10] and [10, 10, 10, 10] don't hash to the
// same thing.  It's worth noting that since a Move won't ever have more
// than four cards in it, our search space is relatively small.
public struct Move : Hashable, ExpressibleByArrayLiteral {
    public let cards: [Card]
    public let hashValue: Int

    public init(arrayLiteral elements: Card...) {
        self.init(elements)
    }

    public init(_ elements: [Card]) {
        cards = elements
        hashValue = hashOfCards(e: elements)
    }

}

// TODO: I think this still risks collisions
private func hashOfCards(e: [Card]) -> Int {
    if e.count > 4 {
        fatalError("Struct Move isn't set up to hash Moves with more than four values!  Given: \(e)")
    }

    let zipped = zip(e.map({ $0.rawValue }), [117, 213, 311, 477])
    return zipped.map({ $0.0 * $0.1 + $0.0 + $0.1/2}).reduce(0, +)
}

public func ==(lhs: Move, rhs: Move) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

