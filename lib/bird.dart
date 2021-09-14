
import 'package:flutter/cupertino.dart';

class Bird extends StatelessWidget {
  const Bird({
    Key? key,
    required this.birdY,
    this.onEnd,
  }) : super(key: key);

  final double birdY;
  final Function? onEnd;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.linearToEaseOut,
      onEnd: () {
        onEnd?.call();
      },
      alignment: Alignment(-0.8, birdY),
      duration: Duration(milliseconds: 500),
      child: Container(
        width: 40,
        height: 40,
        child: Image.asset("assets/images/bird.jpeg"),
      ),
    );
  }
}
