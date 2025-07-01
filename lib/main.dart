import 'package:flame/game.dart';
import 'package:flappio/game.dart';
import 'package:flutter/material.dart';

void main() {
  final game = FlappioGame();
  runApp(MainApp(
    game: game,
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.game});
  final FlappioGame game;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameWidget(
        game: game,
        // Register overlay
        overlayBuilderMap: {
          'MainMenu': (context, _) => MainMenuScreen(game: game),
          'GameOver': (context, _) => GameOverScreen(game: game),
        },
      ),
    );
  }
}

class MainMenuScreen extends StatelessWidget {
  final FlappioGame game;

  const MainMenuScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Flappio',
              style: TextStyle(
                fontSize: 64,
                color: Colors.white,
                fontFamily: 'Game',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: game.startGame,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text(
                'Start',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Game Over Screen Widget
class GameOverScreen extends StatelessWidget {
  final FlappioGame game;
  const GameOverScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Game Over',
              style: TextStyle(
                fontSize: 64,
                color: Colors.white,
                fontFamily: 'Game',
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Score: ${game.score}',
              style: const TextStyle(
                fontSize: 32,
                color: Colors.white,
                fontFamily: 'Game',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: game.startGame,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text(
                'Restart',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
