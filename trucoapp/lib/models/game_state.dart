import 'deck.dart';
import 'player.dart';
import 'card.dart';

enum RoundStage { notStarted, inProgress, finished }

class GameState {
  Deck deck;
  Player player1;
  Player player2;
  List<Card> table = [];
  int currentPlayerIndex = 0;
  RoundStage roundStage = RoundStage.notStarted;

  GameState(this.player1, this.player2) : deck = Deck();

  void startRound() {
    deck.shuffle();
    player1.receiveCards(deck.deal(3));
    player2.receiveCards(deck.deal(3));
    table.clear();
    currentPlayerIndex = 0;
    roundStage = RoundStage.inProgress;
  }

  Player get currentPlayer => currentPlayerIndex == 0 ? player1 : player2;

  void playCard(int cardIndex) {
    if (roundStage == RoundStage.inProgress) {
      table.add(currentPlayer.playCard(cardIndex));
      currentPlayerIndex = (currentPlayerIndex + 1) % 2;

      if (table.length == 2) {
        determineRoundWinner();
      }
    }
  }

  void determineRoundWinner() {
    // Assuming higher card value wins
    if (table[0].value > table[1].value) {
      player1.score++;
    } else {
      player2.score++;
    }

    table.clear();

    if (player1.hand.isEmpty && player2.hand.isEmpty) {
      roundStage = RoundStage.finished;
    }
  }
}
