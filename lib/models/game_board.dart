import 'dart:math';
import 'package:flutter/material.dart';

class GameBoard with ChangeNotifier {
  late List<List<int>> _grid;
  final int _size;
  int _score = 0;
  List<int> _scoreHistory = [];
  Map<int, int> _highScores = {};

  int get score => _score;
  int get size => _size;
  List<List<int>> get grid => _grid;
  List<int> get scoreHistory => _scoreHistory;

  // Récupère le highscore actuel en fonction de la taille de la grille
  int get highScore => _highScores[_size] ?? 0;

  // Constructeur qui initialise la grille et ajoute deux tuiles aléatoires au début.
  GameBoard({int size = 4}) : _size = size {
    _grid = List.generate(size, (_) => List.filled(size, 0));
    _addRandomTile();
    _addRandomTile();
  }

  // Ajoute le score à l'historique lorsque la partie se termine
  void addScoreToHistory() {
    _scoreHistory.add(_score);

    // Met à jour le highscore pour la taille de la grille actuelle
    if (_highScores[_size] == null || _score > _highScores[_size]!) {
      _highScores[_size] = _score;
    }

    notifyListeners();
  }

  // Ajoute une tuile aléatoire (2 ou 4) dans une case vide de la grille.
  void _addRandomTile() {
    List<int> emptyCells = [];
    for (int i = 0; i < _size; i++) {
      for (int j = 0; j < _size; j++) {
        if (_grid[i][j] == 0) {
          emptyCells.add(i * _size + j);
        }
      }
    }
    if (emptyCells.isNotEmpty) {
      int randomIndex = emptyCells[Random().nextInt(emptyCells.length)];
      int row = randomIndex ~/ _size;
      int col = randomIndex % _size;
      _grid[row][col] = Random().nextInt(10) == 0 ? 4 : 2;
    }
    notifyListeners();
  }

  // Vérifie si le jeu est terminé (plus de mouvements possibles).
  bool get isGameOver {
    return !_canMove();
  }

  // Gère le déplacement des tuiles vers la gauche.
  void _moveLeft() {
    bool moved = false;
    for (int i = 0; i < _size; i++) {
      List<int> newRow = _mergeTiles(_grid[i]);
      if (newRow != _grid[i]) {
        _grid[i] = newRow;
        moved = true;
      }
    }
    if (moved) {
      _addRandomTile();
    }
  }

  // Gère le déplacement des tuiles vers la droite.
  void _moveRight() {
    bool moved = false;
    for (int i = 0; i < _size; i++) {
      List<int> newRow = _mergeTiles(_grid[i].reversed.toList());
      newRow = newRow.reversed.toList();
      if (newRow != _grid[i]) {
        _grid[i] = newRow;
        moved = true;
      }
    }
    if (moved) {
      _addRandomTile();
    }
  }

  // Gère le déplacement des tuiles vers le haut.
  void _moveUp() {
    _transpose();
    _moveLeft();
    _transpose();
  }

  // Gère le déplacement des tuiles vers le bas.
  void _moveDown() {
    _transpose();
    _moveRight();
    _transpose();
  }

  // Fusionne les tuiles adjacentes identiques et compresse les espaces vides.
  List<int> _mergeTiles(List<int> row) {
    List<int> mergedRow = List.filled(_size, 0);
    int currentIndex = 0;

    for (int i = 0; i < _size; i++) {
      if (row[i] != 0) {
        if (currentIndex > 0 && mergedRow[currentIndex - 1] == row[i]) {
          // Fusionner les tuiles adjacentes identiques.
          mergedRow[currentIndex - 1] *= 2;
          _score += mergedRow[currentIndex - 1];
        } else {
          mergedRow[currentIndex] = row[i];
          currentIndex++;
        }
      }
    }
    return mergedRow;
  }

  // Gère le déplacement dans la direction donnée (haut, bas, gauche, droite).
  void move(Direction direction) {
    switch (direction) {
      case Direction.up:
        _moveUp();
        break;
      case Direction.down:
        _moveDown();
        break;
      case Direction.left:
        _moveLeft();
        break;
      case Direction.right:
        _moveRight();
        break;
    }
    notifyListeners();
  }

  // Réinitialise la grille et le score, et ajoute deux nouvelles tuiles.
  void reset() {
    _grid = List.generate(_size, (_) => List.filled(_size, 0));
    _addRandomTile();
    _addRandomTile();
    _score = 0; // Réinitialise le score à 0
    notifyListeners();
  }

  // Transpose la grille (échanger les lignes et les colonnes).
  void _transpose() {
    for (int i = 0; i < _size; i++) {
      for (int j = i + 1; j < _size; j++) {
        int temp = _grid[i][j];
        _grid[i][j] = _grid[j][i];
        _grid[j][i] = temp;
      }
    }
  }

  // Vérifie s'il reste des mouvements possibles (fusion ou déplacement).
  bool _canMove() {
    for (int i = 0; i < _size; i++) {
      for (int j = 0; j < _size; j++) {
        if (_grid[i][j] == 0 ||
            (i > 0 && _grid[i][j] == _grid[i - 1][j]) ||
            (i < _size - 1 && _grid[i][j] == _grid[i + 1][j]) ||
            (j > 0 && _grid[i][j] == _grid[i][j - 1]) ||
            (j < _size - 1 && _grid[i][j] == _grid[i][j + 1])) {
          return true;
        }
      }
    }
    return false;
  }
}

enum Direction { up, down, left, right }
