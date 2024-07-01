import 'deck.dart';
import 'player.dart';
import 'card.dart';

enum RoundStage { notStarted, inProgress, finished }

enum TrucoStage { notCalled, trucoCalled, seisCalled, noveCalled, dozeCalled }

class GameState {
  Deck deck;
  Player player1;
  Player player2;
  List<Card> table = [];
  int currentPlayerIndex = 0;
  RoundStage roundStage = RoundStage.notStarted;
  TrucoStage trucoStage = TrucoStage.notCalled;
  int trucoMultiplier = 1; // Base multiplier for truco calls

  GameState(this.player1, this.player2) : deck = Deck();

  void startRound() {
    deck.shuffle();
    player1.receiveCards(deck.deal(3));
    player2.receiveCards(deck.deal(3));
    table.clear();
    currentPlayerIndex = 0;
    roundStage = RoundStage.inProgress;
    trucoStage = TrucoStage.notCalled;
    trucoMultiplier = 1;
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
    // Determine winner logic based on card values
    if (table[0].value > table[1].value) {
      player1.score += trucoMultiplier;
    } else {
      player2.score += trucoMultiplier;
    }

    table.clear();

    if (player1.hand.isEmpty && player2.hand.isEmpty) {
      roundStage = RoundStage.finished;
      // Handle end of game (Navigate to GameOverScreen or show a message)
    }
  }

  void callTruco() {
    if (trucoStage == TrucoStage.notCalled) {
      trucoStage = TrucoStage.trucoCalled;
      trucoMultiplier = 2;
      // Optionally notify UI or players about the truco call
    }
  }

  void callSeis() {
    if (trucoStage == TrucoStage.trucoCalled) {
      trucoStage = TrucoStage.seisCalled;
      trucoMultiplier = 3;
      // Optionally notify UI or players about the Seis call
    }
  }

  void callNove() {
    if (trucoStage == TrucoStage.seisCalled) {
      trucoStage = TrucoStage.noveCalled;
      trucoMultiplier = 4;
      // Optionally notify UI or players about the Nove call
    }
  }

  void callDoze() {
    if (trucoStage == TrucoStage.noveCalled) {
      trucoStage = TrucoStage.dozeCalled;
      trucoMultiplier = 6;
      // Optionally notify UI or players about the Doze call
    }
  }
}
