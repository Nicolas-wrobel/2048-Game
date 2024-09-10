# 2048 Flutter Game

Ce projet est une implémentation du célèbre jeu 2048 en Flutter, conçu pour être utilisé sur des plateformes mobiles (Android) et web. Le projet utilise **Provider** pour la gestion de l'état, ce qui permet de rendre les interactions fluides et réactives.

## Fonctionnalités
- Glissement (swipe) dans quatre directions (haut, bas, gauche, droite) pour déplacer les tuiles.
- Fusion des tuiles avec des valeurs identiques.
- Suivi du score et du highscore (qui dépend de la taille de la grille).
- Sélection de la taille de la grille : 3x3, 4x4 ou 5x5.
- Fin de partie avec un popup indiquant le score.
- Animations pour l'apparition et la fusion des tuiles.
- Page d'accueil avec options de configuration et écran des règles.

## Structure du projet

### 1. **Main Application Flow**
- `main.dart`: Le fichier d'entrée principal de l'application. Il initialise l'application et configure les routes.

### 2. **Écrans Principaux**
- `game_screen.dart`: L'écran principal où se déroule le jeu. Il affiche la grille, le score, le highscore, et le bouton pour réinitialiser la partie.
- `home_screen.dart`: L'écran d'accueil où l'utilisateur peut choisir la taille de la grille et accéder aux règles du jeu.
- `rules_screen.dart`: Affiche les règles du jeu dans un style cohérent avec le thème de l'application.

### 3. **Modèles**
- `game_board.dart`: Le modèle de données qui gère l'état du jeu, y compris la grille, le score actuel, l'historique des scores, et le highscore pour chaque taille de grille. Cette classe utilise **Provider** pour notifier l'interface utilisateur des changements.

### 4. **Widgets**
- `grid.dart`: Un widget qui génère et affiche la grille de jeu avec les tuiles (tiles). Utilise `GridView` pour organiser les tuiles en fonction de la taille de la grille sélectionnée.
- `tile.dart`: Un widget qui représente une tuile individuelle. Ce widget gère également les animations d'apparition et de fusion des tuiles.

### 5. **Gestion de l'état**
L'état est géré via le package **Provider** pour permettre la réactivité de l'application. Les widgets comme `Consumer<GameBoard>` réagissent automatiquement lorsque le modèle `GameBoard` change, rendant ainsi l'interface utilisateur fluide et réactive.

## Comment jouer
- Utilisez les swipes (haut, bas, gauche, droite) pour déplacer les tuiles.
- Lorsque deux tuiles avec le même nombre se touchent, elles fusionnent en une seule.
- Le but est d'atteindre la tuile 2048, mais vous pouvez continuer à jouer après avoir atteint cet objectif.
- Le jeu se termine lorsque vous ne pouvez plus faire de mouvements possibles.

## Installation

1. Clonez ce dépôt sur votre machine locale :
   ```bash
   git clone https://github.com/votre-utilisateur/2048-flutter-game.git
   cd 2048-flutter-game
   ```
2. Installez les dépendances Flutter :
   ```bash
   flutter pub get
   ```
3. Exécutez l'application sur un émulateur ou un appareil connecté :
   ```bash
   flutter run
   ```

## Structure du projet
```bash
├── lib
│   ├── main.dart          # Point d'entrée de l'application
│   ├── models
│   │   └── game_board.dart # Modèle de données du jeu 2048
│   ├── widgets
│   │   ├── grid.dart       # Grille du jeu
│   │   └── tile.dart       # Tuiles animées du jeu
│   ├── screens
│   │   ├── game_screen.dart # Écran principal du jeu
│   │   ├── home_screen.dart # Écran d'accueil
│   │   └── rules_screen.dart # Écran des règles du jeu
├── pubspec.yaml            # Fichier de configuration pour Flutter
```
