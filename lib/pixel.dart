import 'package:flutter/material.dart';

class Pixel extends StatelessWidget {
  final Color color;
  final child;
  Pixel({super.key, required this.color, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
        margin: EdgeInsets.all(2),
        child: Center(
            child:
                Text(child.toString(), style: TextStyle(color: Colors.white))));
  }
}
