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
            // check the new position if it is valid or not
            if (piecePositionIsValid(newPosition)) {
              //Update new position
              position = newPosition;

              //update rotate state
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 1:
            /*
          0 0 0 
          0
          */

            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
            ];
            // check the new position if it is valid or not
            if (piecePositionIsValid(newPosition)) {
              //Update new position
              position = newPosition;

              //update rotate state
              rotateState = (rotateState + 1) % 4;
            }
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
            // check the new position if it is valid or not
            if (piecePositionIsValid(newPosition)) {
              //Update new position
              position = newPosition;

              //update rotate state
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 3:
            /*
              0
          0 0 0
          */

            newPosition = [
              position[1] - rowLength + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];
            // check the new position if it is valid or not
            if (piecePositionIsValid(newPosition)) {
              //Update new position
              position = newPosition;

              //update rotate state
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.J:
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
            // check the new position if it is valid or not
            if (piecePositionIsValid(newPosition)) {
              //Update new position
              position = newPosition;

              //update rotate state
              rotateState = (rotateState + 1) % 4;
            }
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
            // check the new position if it is valid or not
            if (piecePositionIsValid(newPosition)) {
              //Update new position
              position = newPosition;

              //update rotate state
              rotateState = (rotateState + 1) % 4;
            }
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
            // check the new position if it is valid or not
            if (piecePositionIsValid(newPosition)) {
              //Update new position
              position = newPosition;

              //update rotate state
              rotateState = (rotateState + 1) % 4;
            }
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
            // check the new position if it is valid or not
            if (piecePositionIsValid(newPosition)) {
              //Update new position
              position = newPosition;

              //update rotate state
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.J:
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
              position[1] + rowLength - 1,
            ];
            // check the new position if it is valid or not
            if (piecePositionIsValid(newPosition)) {
              //Update new position
              position = newPosition;

              //update rotate state
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 1:
            /*
          0
          0 0 0 
          */

            newPosition = [
              position[1] - rowLength + 1,
              position[1],
              position[1] - 1,
              position[1] + 1,
            ];
            // check the new position if it is valid or not
            if (piecePositionIsValid(newPosition)) {
              //Update new position
              position = newPosition;

              //update rotate state
              rotateState = (rotateState + 1) % 4;
            }
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
              position[1] - rowLength + 1,
            ];
            // check the new position if it is valid or not
            if (piecePositionIsValid(newPosition)) {
              //Update new position
              position = newPosition;

              //update rotate state
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 3:
            /*
          0 0 0
              0
          */

            newPosition = [
              position[1] + 1,
              position[1],
              position[1] + rowLength,
              position[1] - rowLength + 1,
            ];
            // check the new position if it is valid or not
            if (piecePositionIsValid(newPosition)) {
              //Update new position
              position = newPosition;

              //update rotate state
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.I:
        switch (rotateState) {
          case 0:
            /*
          0 0 0 0
          */

            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + 2,
            ];
            // check the new position if it is valid or not
            if (piecePositionIsValid(newPosition)) {
              //Update new position
              position = newPosition;

              //update rotate state
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 1:
            /*
          0
          0
          0
          0
          */

            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + 2 * rowLength,
            ];
            // check the new position if it is valid or not
            if (piecePositionIsValid(newPosition)) {
              //Update new position
              position = newPosition;

              //update rotate state
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 2:
            /*
          0 0 0 0
          */

            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - 2,
            ];
            // check the new position if it is valid or not
            if (piecePositionIsValid(newPosition)) {
              //Update new position
              position = newPosition;

              //update rotate state
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 3:
            /*
          0
          0
          0
          0
          */

            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - 2 * rowLength,
            ];
            // check the new position if it is valid or not
            if (piecePositionIsValid(newPosition)) {
              //Update new position
              position = newPosition;

              //update rotate state
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.O:
        /*
        Termonito O doesn't rotate
      */
        break;
      case Tetromino.S:
        switch (rotateState) {
          case 0:
            /*
            0 0
          0 0
          */

            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] + rowLength,
            ];
            // check the new position if it is valid or not
            if (piecePositionIsValid(newPosition)) {
              //Update new position
              position = newPosition;

              //update rotate state
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 1:
            /*
          0 
          0 0
            0
          */

            newPosition = [
              position[0] - rowLength,
              position[0],
              position[0] + 1,
              position[0] + rowLength + 1,
            ];
            // check the new position if it is valid or not
            if (piecePositionIsValid(newPosition)) {
              //Update new position
              position = newPosition;

              //update rotate state
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 2:
            /*
            0 0 
          0 0
          */

            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] + rowLength,
            ];
            // check the new position if it is valid or not
            if (piecePositionIsValid(newPosition)) {
              //Update new position
              position = newPosition;

              //update rotate state
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 3:
            /*
          0 
          0 0
            0
          */

            newPosition = [
              position[0] - rowLength,
              position[0],
              position[0] + 1,
              position[0] + rowLength + 1,
            ];
            // check the new position if it is valid or not
            if (piecePositionIsValid(newPosition)) {
              //Update new position
              position = newPosition;

              //update rotate state
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.Z:
        switch (rotateState) {
          case 0:
            /*
          0 0
            0 0
          */

            newPosition = [
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1,
            ];
            // check the new position if it is valid or not
            if (piecePositionIsValid(newPosition)) {
              //Update new position
              position = newPosition;

              //update rotate state
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 1:
            /*
            0
          0 0
          0
          */

            newPosition = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1,
            ];
            // check the new position if it is valid or not
            if (piecePositionIsValid(newPosition)) {
              //Update new position
              position = newPosition;

              //update rotate state
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 2:
            /*
          0 0
            0 0
          */

            newPosition = [
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1,
            ];
            // check the new position if it is valid or not
            if (piecePositionIsValid(newPosition)) {
              //Update new position
              position = newPosition;

              //update rotate state
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 3:
            /*
            0
          0 0
          0
          */

            newPosition = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1,
            ];
            // check the new position if it is valid or not
            if (piecePositionIsValid(newPosition)) {
              //Update new position
              position = newPosition;

              //update rotate state
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.T:
        switch (rotateState) {
          case 0:
            /*
          0
          0 0
          0
          */

            newPosition = [
              position[2] - rowLength,
              position[2],
              position[2] + 1,
              position[2] + rowLength,
            ];
            // check the new position if it is valid or not
            if (piecePositionIsValid(newPosition)) {
              //Update new position
              position = newPosition;

              //update rotate state
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 1:
            /*
          0 0 0
            0
          */

            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength,
            ];
            // check the new position if it is valid or not
            if (piecePositionIsValid(newPosition)) {
              //Update new position
              position = newPosition;

              //update rotate state
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 2:
            /*
            0
          0 0
            0 
          */

            newPosition = [
              position[1] - rowLength,
              position[1] - 1,
              position[1],
              position[1] + rowLength,
            ];
            // check the new position if it is valid or not
            if (piecePositionIsValid(newPosition)) {
              //Update new position
              position = newPosition;

              //update rotate state
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 3:
            /*
            0
          0 0 0
          */

            newPosition = [
              position[2] - rowLength,
              position[2] - 1,
              position[2],
              position[2] + 1,
            ];
            // check the new position if it is valid or not
            if (piecePositionIsValid(newPosition)) {
              //Update new position
              position = newPosition;

              //update rotate state
              rotateState = (rotateState + 1) % 4;
            }
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

  //check if piece is valid position
  bool piecePositionIsValid(List<int> piecePosition) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;

    //Return false if piece position is taken
    for (int pos in piecePosition) {
      if (!positionValid(pos)) {
        return false;
      }

      //get the col of position

      int col = (pos % rowLength);

      // check if the last or first col is accupied
      if (col == 0) {
        firstColOccupied = true;
      }

      if (col == rowLength - 1) {
        lastColOccupied = true;
      }
    }
    //if there is a piece first col or last col, it is going through the wall

    return !(firstColOccupied && lastColOccupied);
  }
}
