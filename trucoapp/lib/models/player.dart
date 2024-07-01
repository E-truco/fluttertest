import 'card.dart';

class Player {
  final String name;
  List<Card> hand = [];

  Player({required this.name});

  void receiveCards(List<Card> cards) {
    hand.addAll(cards);
  }
}
