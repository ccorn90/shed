// A discrete state of the gameplay
// note: for now, we're ignoring the special endgame conditions
public struct State {
    let activePlayerHand: [Card]
    let otherPlayerHand: [Card]

    let pile: [Card]
    let deck: [Card]
}

// Active player makes the given move
// TODO ASSERT: move can be made by the player... we don't check this!
func move(_ move: Move, _ state: State) -> State {
    return State(
        activePlayerHand: Array(move.cards.eachWithObject(ArraySlice(state.activePlayerHand)) {
            $0.remove(at: $0.index(of: $1)!)
        }),
        otherPlayerHand: state.otherPlayerHand,
        pile: move.cards + state.pile,
        deck: state.deck
    )
}

// Active player picks up the pile
func pickUp(_ state: State) -> State {
    return State(
        activePlayerHand: state.activePlayerHand + state.pile,
        otherPlayerHand: state.otherPlayerHand,
        pile: [],
        deck: state.deck
    )
}

// Active player draws until they have N cards or the deck is empty
public let DRAW_HAND_UNTIL = 4
func draw(_ state: State) -> State {
    var hand = state.activePlayerHand
    var deck = ArraySlice(state.deck)
    while hand.count < DRAW_HAND_UNTIL && deck.count > 0 {
        hand += [deck.first!]
        deck = deck.dropFirst()
    }

    return State(
        activePlayerHand: hand,
        otherPlayerHand: state.otherPlayerHand,
        pile: state.pile,
        deck: Array(deck)
    )
}

// Advances to the next player
func nextPlayer(_ state: State) -> State {
    return State(
        activePlayerHand: state.otherPlayerHand,
        otherPlayerHand: state.activePlayerHand,
        pile: state.pile,
        deck: state.deck
    )
}

