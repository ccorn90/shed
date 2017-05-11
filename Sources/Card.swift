public enum Card : UInt {
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6
    case seven = 7
    case eight = 8
    case nine = 9
    case ten = 10
    case jack = 11
    case queen = 12
    case king = 13
    case ace = 14
}

// implement supercession logic for the Shed game:
public func valid(play: Card, onCard: Card) -> Bool {
    // two can always be played:
    if play == .two { return true }

    switch onCard {
        // everything can be played on a two:
        case .two: return true

        // nine only allows less-than or equal to:
        case .nine: return play.rawValue <= Card.nine.rawValue

        // compare based on the raw value:
        default: return play.rawValue > onCard.rawValue
    }
}

