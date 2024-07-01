import 'package:flutter/material.dart';
import '../models/game_state.dart';
import '../models/player.dart';
import '../widgets/card_widget.dart';
import 'package:audioplayers/audioplayers.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late GameState gameState;
  final AudioCache _audioCache = AudioCache();

  @override
  void initState() {
    super.initState();
    Player player1 = Player(name: 'Player 1');
    Player player2 = Player(name: 'Player 2');
    gameState = GameState(player1, player2);
    gameState.startRound();
    _audioCache.load('card_flip.mp3');
  }

  void playCard(int cardIndex) {
    setState(() {
      gameState.playCard(cardIndex);
    });
    _audioCache.play('card_flip.mp3');
  }

  void callTruco() {
    setState(() {
      gameState.callTruco();
    });
    // Optionally play a sound or provide feedback for truco call
  }

  void callSeis() {
    setState(() {
      gameState.callSeis();
    });
    // Optionally play a sound or provide feedback for Seis call
  }

  void callNove() {
    setState(() {
      gameState.callNove();
    });
    // Optionally play a sound or provide feedback for Nove call
  }

  void callDoze() {
    setState(() {
      gameState.callDoze();
    });
    // Optionally play a sound or provide feedback for Doze call
  }

  @override
  Widget build(BuildContext context) {
    double cardHeight = MediaQuery.of(context).size.height / 5;
    double cardWidth = cardHeight / 1.5;

    return Scaffold(
      appBar: AppBar(
        title: Text('Truco Paulista'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${gameState.player1.name} - Score: ${gameState.player1.score}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: gameState.trucoStage == TrucoStage.notCalled
                      ? callTruco
                      : null,
                  child: Text('Truco'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: gameState.trucoStage == TrucoStage.trucoCalled
                      ? callSeis
                      : null,
                  child: Text('Seis'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: gameState.trucoStage == TrucoStage.seisCalled
                      ? callNove
                      : null,
                  child: Text('Nove'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: gameState.trucoStage == TrucoStage.noveCalled
                      ? callDoze
                      : null,
                  child: Text('Doze'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${gameState.player2.name} - Score: ${gameState.player2.score}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
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
      ),
    );
  }
}
