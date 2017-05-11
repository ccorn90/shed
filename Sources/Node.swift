// When simulating plays, we construct a directed graph where each node
// represents a possible state of the game.  Its children are the outcomes from
// each of the moves that the player may take.
indirect enum Node {
    // The final state of the game and the index of the player who won
    case win(State, Int)

    // The state of the game and an index of all possible moves and their
    // results
    case play(State, [Move : Node])

    // The state of the game when a player cannot play and a new node in which
    // the same player has picked up the pile.
    case cannotPlay(State, Node)
}

