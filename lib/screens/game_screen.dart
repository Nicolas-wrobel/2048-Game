import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/models/game_board.dart';
import 'package:myapp/widgets/grid.dart';
import 'package:google_fonts/google_fonts.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Offset _startSwipePosition = Offset.zero;
  bool _swipeDetected = false;
  bool _dialogShown = false; // Empêche l'affichage multiple des dialogues
  static const double swipeThreshold =
      50; // Seuil ajusté pour des mouvements plus significatifs

  @override
  Widget build(BuildContext context) {
    const gridSize = 300.0;

    return Scaffold(
      backgroundColor: const Color(0xFFEFE5DA),
      appBar: AppBar(
        title: Text(
          '2048',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF8F7A66),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Consumer<GameBoard>(
          builder: (context, gameBoard, child) {
            // Vérifier si la partie est terminée
            if (gameBoard.isGameOver && !_dialogShown) {
              gameBoard.addScoreToHistory();
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _dialogShown = true;
                _showGameOverDialog(context, gameBoard.score);
              });
            } else {
              _dialogShown = false;
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFBBADA0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        'Score: ${gameBoard.score}',
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFBBADA0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        'HighScore: ${gameBoard.highScore}',
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Grille avec swipe et listener de swipe
                GestureDetector(
                  onPanStart: (details) {
                    _startSwipePosition = details.localPosition;
                    _swipeDetected =
                        false; // Réinitialise la détection du swipe
                  },
                  onPanUpdate: (details) {
                    if (_swipeDetected)
                      return; // Ne traite plus de swipe après le premier

                    final delta = details.localPosition - _startSwipePosition;
                    final dx = delta.dx;
                    final dy = delta.dy;

                    // Seuil ajusté pour éviter les petits mouvements
                    if (dx.abs() > dy.abs() && dx.abs() > swipeThreshold) {
                      if (dx > 0) {
                        context.read<GameBoard>().move(Direction.right);
                      } else {
                        context.read<GameBoard>().move(Direction.left);
                      }
                      _swipeDetected =
                          true; // Empêche d'autres mouvements pendant ce swipe
                    } else if (dy.abs() > swipeThreshold) {
                      if (dy > 0) {
                        context.read<GameBoard>().move(Direction.down);
                      } else {
                        context.read<GameBoard>().move(Direction.up);
                      }
                      _swipeDetected =
                          true; // Empêche d'autres mouvements pendant ce swipe
                    }
                  },
                  child: SizedBox(
                    width: gridSize,
                    height: gridSize,
                    child: Grid(), // La grille de jeu
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<GameBoard>().reset();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8F7A66),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text('New Game'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Boîte de dialogue pour la fin de partie
  void _showGameOverDialog(BuildContext context, int score) {
    showDialog(
      context: context,
      barrierDismissible: false, // Empêche la fermeture par clic en dehors
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFFAF8EF),
          title: const Text(
            'Game Over',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF8F7A66),
            ),
          ),
          content: Text(
            'Your score: $score',
            style: const TextStyle(
              color: Color(0xFF8F7A66),
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF8F7A66),
                foregroundColor: Colors.white,
              ),
              child: const Text('New Game'),
              onPressed: () {
                Navigator.of(context).pop(); // Ferme la boîte de dialogue
                context.read<GameBoard>().reset(); // Réinitialise la partie
              },
            ),
          ],
        );
      },
    );
  }
}
