import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappio/components/constants.dart';
import 'package:flappio/components/ground.dart';
import 'package:flappio/components/pipe.dart';
import 'package:flappio/game.dart';

class Bird extends SpriteComponent with CollisionCallbacks {
  // Init

  Bird()
      : super(
            position: Vector2(birdStartX, birdStartY),
            size: Vector2(birdWidth, birdHeight));

  // physical world properties

  double velocity = 0;
  double gravity = gameGravity;
  double jumpStrength = birdJumpStrength;

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load('bird.png');

    add(RectangleHitbox());
  }

  void flap() {
    velocity = jumpStrength;
  }

  @override
  void update(double dt) {
    //apply gravity
    velocity += gravity * dt;

    position.y += velocity * dt;
  }

  // collision

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Ground) {
      (parent as FlappioGame).gameOver();
    }

    if (other is Pipe) {
      (parent as FlappioGame).gameOver();
    }
  }
}
