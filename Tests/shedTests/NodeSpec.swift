import Spec
import Nimble
@testable import shed

class NodeSpec : Spec {
    func test() {
        let state = State(
            activePlayerHand: [.three, .three, .three, .three],
            otherPlayerHand: [.ten, .ten, .ten, .ten],
            pile: [],
            deck: [.ace, .king, .queen, .jack]
        )

        print("***********************************")
        let node = compute(newNodeByPlaying(state, [.three]), depth: 12)
        print(describeTree(root: node, depth: 7))
        print("\n\n\n\n")
    }
}
