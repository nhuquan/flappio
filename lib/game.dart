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
import 'package:flutter/material.dart';

class FlappioGame extends FlameGame with TapDetector, HasCollisionDetection {
  /*
  Basic Game Components:
  - bird
  - background
  - ground
  - pipes
  - scores
   */

  late Bird bird;
  late Background background;
  late Ground ground;
  late PipeManager pipeManager;
  late ScoreText scoreText;
  bool isGameOver = false;
  int score = 0;

  @override
  FutureOr<void> onLoad() {
    // load background
    background = Background(size);
    add(background);

    // load bird
    bird = Bird();
    add(bird);

    // load ground
    ground = Ground();
    add(ground);

    // load pipe;
    pipeManager = PipeManager();
    add(pipeManager);

    // load score
    scoreText = ScoreText();
    add(scoreText);
  }

  void incrementScore() {
    score++;
  }

  void gameOver() {
    if (isGameOver) return;

    isGameOver = true;
    pauseEngine();

    // show dialog box to the user;

    showDialog(
        context: buildContext!,
        builder: (context) => AlertDialog(
              title: const Text("Game Over"),
              content: Text("High Score: $score"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      resetGame();
                    },
                    child: const Text('Restart'))
              ],
            ));
  }

  @override
  void onTap() {
    bird.flap();
  }

  void resetGame() {
    bird.position = Vector2(birdStartX, birdStartY);
    bird.velocity = 0;
    score = 0;
    isGameOver = false;
    children.whereType<Pipe>().forEach((Pipe pipe) => pipe.removeFromParent());
    resumeEngine();
  }
}
