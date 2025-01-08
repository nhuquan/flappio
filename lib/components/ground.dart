import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappio/components/constants.dart';
import 'package:flappio/game.dart';

class Ground extends SpriteComponent
    with HasGameRef<FlappioGame>, CollisionCallbacks {
  //
  Ground() : super();

  @override
  FutureOr<void> onLoad() async {
    // set size and position (2x width for infinite scroll)

    size = Vector2(2 * gameRef.size.x, groundHeight);
    position = Vector2(0, gameRef.size.y - groundHeight);

    // load image
    sprite = await Sprite.load('ground.png');

    // add a collision box;
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    // move the ground to the left
    position.x -= groundScrollingSpeed * dt;

    // reset the ground if it goes of the screen for infinite scroll
    // if haft of the ground has been passed, reset.
    if (position.x + size.x / 2 <= 0) {
      position.x = 0;
    }
  }
}
