public func compute(_ node: Node, depth: Int) -> Node {
    var result = node

    // by using matchers on nil, we effectively cache the results, not needing
    // to compute again if we don't have to.
    switch result {
        // if the active player cannot play, the only option is to pick up
        // the pile and play for the next turn
        case .cannotPlay(let state, nil):
            let n = Node.play(pickUp(state), nil)
            result = .cannotPlay(state, n)

            // optionally recur:
            if depth > 0 {
                result = .cannotPlay(state, compute(n, depth: depth-1))
            }

        // a play node must calculate all the available moves and their
        // results.  Either we cannot play, or we have a tree of options,
        // some of which may be wins, the rest of which are plays.
        case .play(let state, nil):
                let moves = plays(forHand: state.activePlayerHand, onPile: state.pile)
                    if moves == [] {
                        result = compute(.cannotPlay(state, nil), depth: depth-1)
                    } else {
                        result = .play(state, moves.eachWithObject([:]) { hash, move in
                            hash![move] = newNodeByPlaying(state, move)

                            // optionally recur:
                            if depth > 0 {
                                hash![move] = compute(hash![move]!, depth: depth-1)
                            }
                        })
                    }

        default: break
    }

    return result
}

public func newNodeByPlaying(_ state: State, _ m: Move) -> Node {
    let afterMoveState = move(m, state)
    if afterMoveState.activePlayerHand == [] {
        return .win(afterMoveState)
    } else {
        return .play(nextPlayer(draw(afterMoveState)), nil)
    }
}
