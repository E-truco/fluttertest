import 'package:flutter/material.dart';
import '../models/game_state.dart';
import '../models/player.dart';
import '../widgets/card_widget.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late GameState gameState;

  @override
  void initState() {
    super.initState();
    Player player1 = Player(name: 'Player 1');
    Player player2 = Player(name: 'Player 2');
    gameState = GameState(player1, player2);
    gameState.startRound();
  }

  void playCard(int cardIndex) {
    setState(() {
      gameState.playCard(cardIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    double cardHeight = MediaQuery.of(context).size.height / 5;
    double cardWidth = cardHeight / 1.5;

    return Scaffold(
      appBar: AppBar(
        title: Text('Truco Paulista'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('${gameState.player1.name} - Score: ${gameState.player1.score}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: gameState.player1.hand
                .map((card) => GestureDetector(
                      onTap: () {
                        if (gameState.currentPlayer == gameState.player1) {
                          playCard(gameState.player1.hand.indexOf(card));
                        }
                      },
                      child: SizedBox(
                        height: cardHeight,
                        width: cardWidth,
                        child: CardWidget(card: card),
                      ),
                    ))
                .toList(),
          ),
          SizedBox(height: 20),
          Text('${gameState.player2.name} - Score: ${gameState.player2.score}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: gameState.player2.hand
                .map((card) => GestureDetector(
                      onTap: () {
                        if (gameState.currentPlayer == gameState.player2) {
                          playCard(gameState.player2.hand.indexOf(card));
                        }
                      },
                      child: SizedBox(
                        height: cardHeight,
                        width: cardWidth,
                        child: CardWidget(card: card),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
