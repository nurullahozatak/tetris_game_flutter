import 'dart:ui';

import 'package:tetris_game/board.dart';
import 'package:tetris_game/values.dart';

class Piece {
  //type of tetris piece
  Tetromino type;
  Piece({required this.type});

  //the piece is just a list of integers
  List<int> position = [];

  //color of pieces
  Color get color {
    return tetrominoColors[type] ?? Color.fromARGB(15, 255, 254, 254);
  }

  //generate the piece

  void intializePiece() {
    switch (type) {
      case Tetromino.L:
        position = [
          -26,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetromino.J:
        position = [
          -25,
          -15,
          -5,
          -6,
        ];
        break;
      case Tetromino.I:
        position = [
          -4,
          -5,
          -6,
          -7,
        ];
        break;
      case Tetromino.O:
        position = [
          -15,
          -16,
          -5,
          -6,
        ];
        break;
      case Tetromino.S:
        position = [
          -15,
          -14,
          -6,
          -5,
        ];
        break;
      case Tetromino.Z:
        position = [
          -17,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetromino.T:
        position = [
          -26,
          -16,
          -6,
          -15,
        ];
        break;
      default:
    }
  }

  //move the piece
  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < position.length; i++) {
          position[i] += rowLength;
        }
        break;
      case Direction.left:
        for (int i = 0; i < position.length; i++) {
          position[i]--;
        }
        break;
      case Direction.right:
        for (int i = 0; i < position.length; i++) {
          position[i]++;
        }
        break;
    }
  }

  //Rotate the piece
  int rotateState = 1;
  void rotatePiece() {
    List<int> newPosition = [];

    switch (type) {
      case Tetromino.L:
        switch (rotateState) {
          case 0:
            /*
          0
          0
          0 0
          */

            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength + 1,
            ];
            //Update new position
            position = newPosition;

            //update rotate state
            rotateState = (rotateState + 1) % 4;
            break;
          case 1:
            /*
          0 0 0 0
          0
          */

            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
            ];
            //Update new position
            position = newPosition;

            //update rotate state
            rotateState = (rotateState + 1) % 4;
            break;
          case 2:
            /*
          0 0 
            0
            0
          */

            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength - 1,
            ];
            //Update new position
            position = newPosition;

            //update rotate state
            rotateState = (rotateState + 1) % 4;
            break;
          case 3:
            /*
          0 0 0 0
                0
          */

            newPosition = [
              position[1] - rowLength + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];
            //Update new position
            position = newPosition;

            //update rotate state
            rotateState = (rotateState + 1) % 4;
            break;
        }
        break;
      default:
    }
  }

  //check if valid position
  bool positionValid(int position) {
    //get the row and col
    int row = (position / rowLength).floor();
    int col = (position % rowLength);

    //if the position is taken return false
    if (row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    }

    //otherwise position is valid
    else {
      return true;
    }
  }
}
