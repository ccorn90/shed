// Return all possible plays given hand and pile.  Top of pile is at the head of list.
func plays(forHand hand: [Card], onPile pile: [Card]) -> [[Card]] {
    let topCard = pile.first
    let playableCards = hand.filter({ topCard == nil || valid(play: $0, onCard: topCard!) })
    let countedPlayableCards: [Card : Int] = playableCards.eachWithObject([:]) { hash, card in
        hash[card] = (hash[card] ?? 0) + 1
    }

    return countedPlayableCards.reduce([]) { list, cardCount in
        list + (1...cardCount.1).map { Array(repeating: cardCount.0, count: $0) }
    }
}

