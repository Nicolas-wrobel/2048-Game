import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/models/game_board.dart';
import 'package:myapp/widgets/tile.dart';

class Grid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameBoard>(
      builder: (context, gameBoard, child) {
        double gridSize = 300.0; // Taille fixe de la grille

        // Calculer la taille d'une tuile en fonction de la taille de la grille
        double tileSize =
            gridSize / gameBoard.size - 8; // Soustraction pour espacement

        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xFFBBADA0),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: SizedBox(
            height: gridSize,
            width: gridSize,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: gameBoard.size * gameBoard.size,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gameBoard.size, // Nombre de colonnes
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                int row = index ~/ gameBoard.size;
                int col = index % gameBoard.size;
                int value = gameBoard.grid[row][col];

                // Si la tuile est vide, afficher une tuile vide avec couleur de fond
                return SizedBox(
                  width: tileSize,
                  height: tileSize,
                  child: value > 0
                      ? Tile(value: value)
                      : Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFCDC1B4),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
