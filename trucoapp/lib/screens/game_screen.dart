import 'package:flutter/material.dart';
import '../models/deck.dart';
import '../models/player.dart';
import '../widgets/card_widget.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late Deck deck;
  late Player player1;
  late Player player2;

  @override
  void initState() {
    super.initState();
    deck = Deck();
    player1 = Player(name: 'Player 1');
    player2 = Player(name: 'Player 2');

    player1.receiveCards(deck.deal(3));
    player2.receiveCards(deck.deal(3));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Truco Paulista'),
      ),
      body: Column(
        children: <Widget>[
          Text(player1.name),
          Row(
            children: player1.hand
                .map((card) => CardWidget(card: card))
                .toList(),
          ),
          Text(player2.name),
          Row(
            children: player2.hand
                .map((card) => CardWidget(card: card))
                .toList(),
          ),
        ],
      ),
    );
  }
}
