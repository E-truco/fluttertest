import 'package:flutter/material.dart';
import '../models/card.dart' as game;

class CardWidget extends StatelessWidget {
  final game.Card card;

  CardWidget({required this.card});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(card.rank, style: TextStyle(fontSize: 20)),
          Text(card.suit, style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
