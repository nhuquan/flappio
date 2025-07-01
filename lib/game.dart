import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappio/components/background.dart';
import 'package:flappio/components/bird.dart';
import 'package:flappio/components/constants.dart';
import 'package:flappio/components/ground.dart';
import 'package:flappio/components/pipe.dart';
import 'package:flappio/components/pipe_manager.dart';
import 'package:flappio/components/score.dart';

// Define the game states
enum GameState { mainMenu, playing, gameOver }

class FlappioGame extends FlameGame with TapDetector, HasCollisionDetection {
  late Bird bird;
  late Background background;
  late Ground ground;
  late PipeManager pipeManager;
  late ScoreText scoreText;
  int score = 0;

  GameState gameState = GameState.mainMenu;

  @override
  FutureOr<void> onLoad() {
    background = Background(size);
    add(background);
    bird = Bird();
    add(bird);
    ground = Ground();
    add(ground);
    pipeManager = PipeManager();
    add(pipeManager);
    scoreText = ScoreText();
    add(scoreText);

    pauseEngine();
    overlays.add('MainMenu');
  }

  void startGame() {
    // If we are already playing, do nothing.
    if (gameState == GameState.playing) return;

    // Reset all game elements to their initial state
    bird.position = Vector2(birdStartX, birdStartY);
    bird.velocity = 0;
    score = 0;
    children.whereType<Pipe>().forEach((pipe) => pipe.removeFromParent());

    // Change state, remove any overlays, and resume the game.
    gameState = GameState.playing;
    overlays.remove('MainMenu');
    overlays.remove('GameOver');
    resumeEngine();
  }

  void incrementScore() {
    score++;
  }

  void gameOver() {
    if (gameState == GameState.gameOver) return;

    gameState = GameState.gameOver;
    pauseEngine();

    overlays.add('GameOver');
  }

  @override
  void onTap() {
    if (gameState == GameState.playing) {
      bird.flap();
    }
  }
}
