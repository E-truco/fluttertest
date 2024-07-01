import 'card.dart';

class Deck {
  List<Card> cards = [];

  Deck() {
    final suits = ['Espadas', 'Copas', 'Ouros', 'Paus'];
    final ranks = [
      {'rank': '4', 'value': 14},
      {'rank': '5', 'value': 13},
      {'rank': '6', 'value': 12},
      {'rank': '7', 'value': 11},
      {'rank': 'Q', 'value': 10},
      {'rank': 'J', 'value': 9},
      {'rank': 'K', 'value': 8},
      {'rank': 'A', 'value': 7},
      {'rank': '2', 'value': 6},
      {'rank': '3', 'value': 5},
    ];

    for (var suit in suits) {
      for (var rank in ranks) {
        cards.add(Card(
          suit: suit,
          rank: rank['rank'] as String,
          value: rank['value'] as int,
        ));
      }
    }

    shuffle();
  }

  void shuffle() {
    cards.shuffle();
  }

  List<Card> deal(int count) {
    return cards.sublist(0, count);
  }
}
