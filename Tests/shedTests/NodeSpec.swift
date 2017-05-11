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
        var node = newNode(state, [.three])
        node.computeChildren()
        print(node)
    }
}
