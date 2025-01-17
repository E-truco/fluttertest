import 'card.dart';

class Player {
  final String name;
  List<Card> hand = [];
  int score = 0;

  Player({required this.name});

  void receiveCards(List<Card> cards) {
    hand.addAll(cards);
  }

  Card playCard(int index) {
    return hand.removeAt(index);
  }
}
