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


public func describeTree(root: Node, depth: Int, indent: Int = 0) -> String {
    guard depth > 0 else { return "no more data here" }
    // Define some helpers:
    var returnString = ""
    let indentString = Array(repeating: " ", count: 4*indent).reduce("", +)
    func line(_ str: String) {
        returnString += "\n" + indentString + str
    }

   // switch root {
   //     case .win(_): returnString += "W "
   //     case .cannotPlay(_, _): returnString += "X "
   //     case .play(_, _): returnString += "P "
   // }

    switch root {
        case .win(let state):
            returnString += "WIN : \(state.activePlayerHand)"

        case .cannotPlay(let state, let node):
            if let node = node {
                returnString += indentString + "\n\(indentString)================================="
                line("==> PICK UP PILE" + describeTree(root: node, depth: depth-1, indent: indent))

            } else {
                returnString += indentString + "\n\(indentString)================================="
                line("==> PICK UP PILE : next node not yet computed")
            }

        case .play(let state, let hash):
            returnString += indentString + "\n\(indentString)== \((hash?.count).map(String.init) ?? "?") moves available ======="
            if let hash = hash {
                var oneline = false
                var index = 0
                hash.forEach { move, node in
                    if oneline == false {
                        oneline = true
                    } else {
                        line("")
                    }

                    line("==> (\(index)) PLAY \(move.cards) : " + describeTree(root: node, depth: depth-1, indent: indent+1))
                    index = index + 1
                }
            } else {
                line("no more data here")
            }
    }


    return returnString
}
