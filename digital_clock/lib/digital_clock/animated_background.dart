import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  final String filename;
  final String animation;
  final FlareControls animationController;

  const AnimatedBackground(
      {this.filename, this.animationController, this.animation});

  @override
  _AnimatedBackgroundState createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlareActor(
        widget.filename,
        animation: widget.animation,
        controller: widget.animationController,
      ),
    );
  }
}
