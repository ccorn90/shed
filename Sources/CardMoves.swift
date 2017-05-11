import Swift_Language_Mods

// Supercession logic for the Shed game:
public func valid(play: Card, onCard: Card) -> Bool {
    // two can always be played:
    if play == .two { return true }

    switch onCard {
        // everything can be played on a two:
        case .two: return true

        // nine only allows less-than or equal to:
        case .nine: return play.rawValue <= Card.nine.rawValue

        // compare based on the raw value:
        default: return play.rawValue >= onCard.rawValue
    }
}

// Return all possible plays given hand and pile.  Top of pile is at the head of list.
public func plays(forHand hand: [Card], onPile pile: [Card]) -> [Move] {
    let topCard = pile.first
    let playableCards = hand.filter({ topCard == nil || valid(play: $0, onCard: topCard!) })
    let countedPlayableCards: [Card : Int] = playableCards.eachWithObject([:]) { hash, card in
        hash[card] = (hash[card] ?? 0) + 1
    }

    return countedPlayableCards.reduce([]) { list, cardCount in
        list + (1...cardCount.1).map {
            Move(Array(repeating: cardCount.0, count: $0))
        }
    }
}

