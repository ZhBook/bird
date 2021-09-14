import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class pipe extends StatelessWidget {
  const pipe({
    Key? key,
    required this.pipeX,
    required this.pipeY,
    required this.pipeSize,
  }) : super(key: key);

  final double pipeX;
  final double pipeY;
  final double pipeSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(pipeX, pipeY),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(width: 2, color: Colors.yellow)),
        width: 60,
        height: pipeSize,
      ),
    );
  }
}
