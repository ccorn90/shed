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
}
