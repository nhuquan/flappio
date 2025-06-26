import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappio/components/constants.dart';
import 'package:flappio/components/ground.dart';
import 'package:flappio/components/pipe.dart';
import 'package:flappio/game.dart';

class Bird extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<FlappioGame> {
  // Init

  Bird()
      : super(
          position: Vector2(birdStartX, birdStartY),
          size: Vector2(birdWidth, birdHeight),
          autoResize: false,
        );

  // physical world properties
  double velocity = 0;
  double gravity = gameGravity;
  double jumpStrength = birdJumpStrength;

  @override
  FutureOr<void> onLoad() async {
    // Load the bird sprite sheet image
    final image = await gameRef.images.load('bird2.png');

    // Define the animation data using SpriteAnimationData.sequenced
    // Based on your JSON:
    // - Each frame is 34x24 pixels.
    // - There are 3 frames in total (102 / 34 = 3).
    // - They are laid out sequentially in a single row.
    final spriteSheetData = SpriteAnimationData.sequenced(
      amount: 3, // total number of sprite in the animation
      stepTime: 0.1, // Duration for each frame in seconds
      textureSize: Vector2(34, 34), // Size of each frame in the sprite sheet
      loop: true, // loop forever
    );

    animation = SpriteAnimation.fromFrameData(image, spriteSheetData);

    add(RectangleHitbox());
  }

  void flap() {
    velocity = jumpStrength;
  }

  @override
  void update(double dt) {
    super.update(dt);

    //apply gravity
    velocity += gravity * dt;
    position.y += velocity * dt;

    // Prevent bird from flying off the top of the screen
    if (position.y < 0) {
      position.y = 0;
      velocity = 0;
    }
  }

  // collision

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    velocity = 0;

    if (other is Ground) {
      (parent as FlappioGame).gameOver();
    }

    if (other is Pipe) {
      (parent as FlappioGame).gameOver();
    }
  }
}
