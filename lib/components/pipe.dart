import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappio/components/constants.dart';
import 'package:flappio/game.dart';

class Pipe extends SpriteComponent
    with CollisionCallbacks, HasGameRef<FlappioGame> {
  //

  final bool isTopPipe;
  bool scored = false;

  Pipe(Vector2 position, Vector2 size, {required this.isTopPipe})
      : super(position: position, size: size);

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load(isTopPipe ? 'top_pipe.png' : 'bottom_pipe.png');
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    // move pipe to the left as the game loop
    position.x -= groundScrollingSpeed * dt;

    // check if the bird has passed this pipe
    if (!scored && position.x + size.x < gameRef.bird.position.x) {
      scored = true;
      if (isTopPipe) {
        gameRef.incrementScore();
      }
    }

    // remove the pipe if it goes off the screen
    if (position.x + size.x <= 0) {
      removeFromParent();
    }
  }
}
