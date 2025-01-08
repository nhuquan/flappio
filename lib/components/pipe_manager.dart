import 'dart:math';

import 'package:flame/components.dart';
import 'package:flappio/components/constants.dart';
import 'package:flappio/components/pipe.dart';
import 'package:flappio/game.dart';

class PipeManager extends Component with HasGameRef<FlappioGame> {
  // update -> every second (dt)
  // create new pipe

  double pipeSpawnTimer = 0;

  @override
  void update(double dt) {
    // generate new pipe

    pipeSpawnTimer += dt;
    const double pipeInterval = gamePipeInterval;

    if (pipeSpawnTimer > pipeInterval) {
      pipeSpawnTimer = 0;
      spawnPipe();
    }
  }

  void spawnPipe() {
    final double screenHeight = gameRef.size.y;
    const double pipeGap = gamePipeGap;
    const double minPipeHeight = gameMinPipeHeight;
    const double pipeWidth = gamePipeWidth;

    // calculate pipe height
    // max possible pipe height
    final double maxPipeHeight =
        screenHeight - groundHeight - pipeGap - minPipeHeight;

    // height of the bottom pipe
    final double bottomPipeHeight =
        minPipeHeight + Random().nextDouble() * (maxPipeHeight - minPipeHeight);

    // height of the top
    final double topPipeHeight =
        screenHeight - groundHeight - bottomPipeHeight - pipeGap;

    //create

    final bottomPipe = Pipe(
      // position
      Vector2(gameRef.size.x, screenHeight - groundHeight - bottomPipeHeight),
      // size
      Vector2(pipeWidth, bottomPipeHeight),
      isTopPipe: false,
    );

    final topPipe = Pipe(
      // position
      Vector2(gameRef.size.x, 0),
      // size
      Vector2(pipeWidth, topPipeHeight),
      //
      isTopPipe: true,
    );

    gameRef.add(bottomPipe);
    gameRef.add(topPipe);
  }
}
