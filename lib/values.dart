import 'package:flutter/material.dart';

int rowLength = 10;
int columnLength = 15;
int currentScore = 0;

enum Direction { right, left, down }

enum Tetromino { L, J, I, O, S, Z, T }

const Map<Tetromino, Color> tetrominoColors = {
  Tetromino.L: Color.fromARGB(255, 188, 36, 36),
  Tetromino.J: Colors.red,
  Tetromino.I: Colors.blue,
  Tetromino.O: Color.fromARGB(255, 232, 46, 210),
  Tetromino.S: Colors.green,
  Tetromino.Z: Colors.purple,
  Tetromino.T: Colors.orange,
};
