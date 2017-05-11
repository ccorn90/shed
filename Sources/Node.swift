// When simulating plays, we construct a directed graph where each node
// represents a possible state of the game.  Its children are the outcomes from
// each of the moves that the player may take.
public indirect enum Node {
    // The final state of the game.  The activePlayer won.
    case win(State)

    // The state of the game and an index of all possible moves and their
    // results
    case play(State, [Move : Node]?)

    // The state of the game when a player cannot play and a new node in which
    // the same player has picked up the pile.
    case cannotPlay(State, Node?)
}

extension Node {
    public mutating func computeChildren() {
        // by using matchers on nil, we effectively cache the results
        switch self {
            // if the active player cannot play, the only option is to pick up
            // the pile and play for the next turn
            case .cannotPlay(let state, nil):
                self = .cannotPlay(state, .play(pickUp(state), nil))

            // a play node must calculate all the available moves and their
            // results.  Either we cannot play, or we have a tree of options,
            // some of which may be wins, the rest of which are plays.
            case .play(let state, nil):
                let moves = plays(forHand: state.activePlayerHand, onPile: state.pile)
                if moves == [] {
                    self = .cannotPlay(state, nil)  // TODO: compute this immediately?
                } else {
                    self = .play(state, moves.eachWithObject([:]) { hash, move in
                        hash[move] = newNode(state, move)
                    })
                }

            default: break
        }
    }
}

public func newNode(_ state: State, _ m: Move) -> Node {
    let afterMoveState = move(m, state)
    if afterMoveState.activePlayerHand == [] {
        return .win(afterMoveState)
    } else {
        return .play(nextPlayer(draw(afterMoveState)), nil)
    }
}
