import Spec
import Nimble
@testable import shed

class StateSpec : Spec {
    func testTransformationMethods() {
        var state: State!
        before() {
            state = State(
                activePlayerHand: [.ace, .ace, .king],
                otherPlayerHand: [.ace, .five, .six],
                pile: [.five, .four, .two],
                deck: [.three, .four, .ten]
            )
        }


        describe("#move on a state") {
            it("removes the cards of the move from the active player's hand") {
                expect(move([.ace, .ace], state).activePlayerHand).to(
                    equal([.king])
                )
            }

            it("puts the cards of the move on top of the pile") {
                expect(move([.ace, .ace], state).pile).to(
                    equal([.ace, .ace] + state.pile)
                )
            }

            it("does not change the other properties") {
                let newState = move([.ace, .ace], state)
                expect(newState.otherPlayerHand).to(equal(state.otherPlayerHand))
                expect(newState.deck).to(equal(state.deck))
            }
        }

        describe("#pickUp on a state") {
            it("puts the pile into the active player's hand") {
                expect(pickUp(state).activePlayerHand).to(
                    contain(state.activePlayerHand + state.pile)
                )
            }

            it("sets the pile to an empty list") {
                expect(pickUp(state).pile).to(beEmpty())
            }

            it("does not change the other properties") {
                let newState = pickUp(state)
                expect(newState.otherPlayerHand).to(equal(state.otherPlayerHand))
                expect(newState.deck).to(equal(state.deck))
            }
        }

        describe("#draw on a state") {
            describe("when active player has a hand of four or more cards") {
                it("does not change anything") {
                    let state = State(
                        activePlayerHand: [.nine, .nine, .three, .jack],
                        otherPlayerHand: [.ace, .five, .six],
                        pile: [.five, .four, .two],
                        deck: [.three, .four, .ten]
                    )

                    let newState = draw(state)
                    expect(newState.activePlayerHand).to(equal(state.activePlayerHand))
                    expect(newState.otherPlayerHand).to(equal(state.otherPlayerHand))
                    expect(newState.pile).to(equal(state.pile))
                    expect(newState.deck).to(equal(state.deck))
                }
            }

            describe("when active player has fewer than four cards") {
                it("results in the active player having four cards") {
                    expect(draw(state).activePlayerHand.count).to(equal(4))
                }

                it("moves cards from the top of the deck into the active player's hand") {
                    expect(draw(state).activePlayerHand).to(
                        contain(.ace, .ace, .king, .three)
                    )

                    expect(draw(state).deck).to(
                        equal([.four, .ten])
                    )
                }

                it("does not change the other properties") {
                    let newState = draw(state)
                    expect(newState.otherPlayerHand).to(equal(state.otherPlayerHand))
                    expect(newState.pile).to(equal(state.pile))
                }
            }
        }

        describe("#nextPlayer on a state") {
            it("switches the active and other hands") {
                expect(nextPlayer(state).activePlayerHand).to(equal(state.otherPlayerHand))
                expect(nextPlayer(state).otherPlayerHand).to(equal(state.activePlayerHand))
            }

            it("does not change the other properties") {
                expect(nextPlayer(state).pile).to(equal(state.pile))
                expect(nextPlayer(state).deck).to(equal(state.deck))
            }
        }
    }
}
