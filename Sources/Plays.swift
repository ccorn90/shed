// Return all possible plays given hand and pile.  Top of pile is head of list
func plays(forHand hand: [Card], onPile pile: [Card]) -> [[Card]] {
    let topCard = pile.first
    let playableCards = hand.filter({ topCard == nil || valid(play: $0, onCard: topCard!) })
    let countedPlayableCards: [Card : UInt] = playableCards.reduce([:]) { hash, card in

    }
}



