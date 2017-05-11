import Nimble
@testable import shed

class PlaysSpec : Spec {
    func testValidPlay() {
        //describe("playing cards in ascending order, except for 9") {
        Array(2...13)
            .filter({ $0 != 9 })
            .map { ($0, $0 + 1) }
        .map { (Card(rawValue: $0.0)!, Card(rawValue: $0.1)!) }
        .forEach { card0, card1 in
            it("\(card1) may be played on \(card0)") {
                expect(valid(play: card1, onCard: card0)).to(beTruthy())
            }
        }
        //}

        (2...14).flatMap(Card.init).forEach { card in
            it("\(card) may be played on a two") {
                expect(valid(play: card, onCard: .two)).to(beTruthy())
            }
        }

        (2...14).flatMap(Card.init).forEach { card in
            it("two may be played on \(card)") {
                expect(valid(play: .two, onCard: card)).to(beTruthy())
            }
        }

        (2...9).flatMap(Card.init).forEach { card in
            it("\(card) may be played on a nine") {
                expect(valid(play: card, onCard: .nine)).to(beTruthy())
            }
        }

        (10...14).flatMap(Card.init).forEach { card in
            it("\(card) may not be played on a nine") {
                expect(valid(play: card, onCard: .nine)).to(beFalsy())
            }
        }
    }

    func testPlays() {
        //describe("in conditions where no plays are available") {
        it("returns an empty array if there are no cards in the hand") {
            expect(plays(forHand: [], onPile: [.two])).to(beEmpty())
        }

        Array(2...13)
            .filter({ $0 != 9 })
            .map { ($0, $0 + 1) }
        .map { (Card(rawValue: $0.0)!, Card(rawValue: $0.1)!) }
        .forEach { card0, card1 in
            it("returns an empty array because \(card0) cannot supercede \(card1)") {
                expect(plays(forHand: [card0], onPile: [card1])).to(beEmpty())
            }
        }

        it("returns an empty array if the pile has a 9 and the hand has no low cards") {
            expect(plays(forHand: [.king, .queen, .jack, .ten], onPile: [.nine])).to(beEmpty())
        }
        //}

        //describe("a higher card can be played on a card it supercedes") {
        Array(2...13)
            .filter({ $0 != 9 })
            .map { ($0, $0 + 1) }
        .map { (Card(rawValue: $0.0)!, Card(rawValue: $0.1)!) }
        .forEach { card0, card1 in
            it("allows \(card1) to be played on \(card0)") {
                let x = plays(forHand: [card1], onPile: [card0])
                    expect(plays: x, toContain: [card1])
            }
        }
        //}

        //describe("a card can be played on a card of its same value") {
        Array(2...13)
            .filter({ $0 != 9 })
            .flatMap(Card.init)
            .forEach { card in
                it("allows \(card) to be played on \(card)") {
                    let x = plays(forHand: [card], onPile: [card])
                        expect(plays: x, toContain: [card])
                }
            }
        //}

        //describe("cards less than or equal to 9 may be played on a 9") {
        (2...9).flatMap(Card.init).forEach { card in
            it("allows \(card) to be played on \(Card.nine)") {
                let x = plays(forHand: [card], onPile: [.nine])
                    expect(plays: x, toContain: [card])
            } 
        }
        //}

        //describe("multiple possible plays") {
        it("returns all plays when more than one is available") {
            let hand = (2...5).flatMap(Card.init)
                let x = plays(forHand: hand, onPile: [.three])
                hand.forEach { expect(plays: x, toContain: [$0]) }
        }

        it("returns all combinations when a hand includes multiple of the same card") {
            let hand = [2, 2, 2, 2].flatMap(Card.init)
                let x = plays(forHand: hand, onPile: [.ace])
                expect(plays: x, toContain: [.two])
                expect(plays: x, toContain: [.two, .two])
                expect(plays: x, toContain: [.two, .two, .two])
                expect(plays: x, toContain: [.two, .two, .two, .two])
        }

        it("returns all combinations in a complex scenario") {
            let hand = [2, 2, 11, 11, 14].flatMap(Card.init)
                let x = plays(forHand: hand, onPile: [.five])
                expect(plays: x, toContain: [.two])
                expect(plays: x, toContain: [.two, .two])
                expect(plays: x, toContain: [.jack])
                expect(plays: x, toContain: [.jack, .jack])
                expect(plays: x, toContain: [.ace])
        }
        //}
    }
}

func expect(plays: [[Card]], toContain: [Card]) {
    let verified = plays.map { $0 == toContain }
    expect(verified).to(contain(true), description: "\(plays) should contain \(toContain)")
}

