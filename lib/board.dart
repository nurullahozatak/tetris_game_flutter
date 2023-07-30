import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tetris_game/piece.dart';
import 'package:tetris_game/pixel.dart';
import 'package:tetris_game/values.dart';

//All peaces will be null at the beginning
List<List<Tetromino?>> gameBoard =
    List.generate(columnLength, (i) => List.generate(rowLength, (j) => null));

class GameBoard extends StatefulWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  //current tetris piece
  Piece currentPiece = Piece(type: Tetromino.L);

  @override
  void initState() {
    super.initState();
    //start game when app starts
    startGame();
  }

  void startGame() {
    currentPiece.intializePiece();

    //frame refresh rate
    Duration frameRate = const Duration(milliseconds: 800);
    gameLoop(frameRate);
  }

  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
        checkLanding();

        currentPiece.movePiece(Direction.down);
      });
    });
  }

  //check for collision
  // return true -> there is a collision
  // return false -> there is no collision

  bool checkCollision(Direction direction) {
    // loop through all direction index
    for (int i = 0; i < currentPiece.position.length; i++) {
      // calculate the index of the current piece
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = (currentPiece.position[i] % rowLength);

      // directions
      if (direction == Direction.down) {
        row++;
      } else if (direction == Direction.right) {
        col++;
      } else if (direction == Direction.left) {
        col--;
      }

      // check for collisions with boundaries
      if (col < 0 || col >= rowLength || row >= columnLength) {
        return true;
      }

      // check for collisions with other landed pieces
      if (row >= 0 && gameBoard[row][col] != null) {
        return true;
      }
    }
    // if there is no collision return false
    return false;
  }

  void checkLanding() {
    if (checkCollision(Direction.down)) {
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = (currentPiece.position[i] % rowLength);

        // when the last piece is landed it will restart the location of the new piece
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }

      createNewPiece();

      // check for completed lines
      checkCompletedLines();
    }
  }

  void checkCompletedLines() {
    for (int row = columnLength - 1; row >= 0; row--) {
      bool isLineCompleted = true;
      for (int col = 0; col < rowLength; col++) {
        if (gameBoard[row][col] == null) {
          isLineCompleted = false;
          break;
        }
      }
      if (isLineCompleted) {
        // remove the completed line
        for (int i = row; i > 0; i--) {
          for (int col = 0; col < rowLength; col++) {
            gameBoard[i][col] = gameBoard[i - 1][col];
          }
        }
        // clear the top row
        for (int col = 0; col < rowLength; col++) {
          gameBoard[0][col] = null;
        }
        // check for additional completed lines
        row++;
      }
    }
  }

  bool checkLanded() {
    // loop through each position of the current piece
    for (int i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;

      // check if the cell below is already occupied
      if (row + 1 < columnLength &&
          row >= 0 &&
          gameBoard[row + 1][col] != null) {
        return true; // collision with a landed piece
      }
    }

    return false; // no collision with landed pieces
  }

  void createNewPiece() {
    Random random = Random();
    Tetromino randomType =
        Tetromino.values[random.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.intializePiece();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 32, 28, 28),
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 57, 53, 74),
          centerTitle: true,
          title: Text("Tetris")),
      body: GridView.builder(
          itemCount: columnLength * rowLength,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: rowLength),
          itemBuilder: (context, index) {
            //get row and col of each index
            int row = (index / rowLength).floor();
            int col = (index % rowLength);

            //cutrrent piece
            if (currentPiece.position.contains(index)) {
              return Pixel(
                color: Color.fromARGB(255, 106, 255, 0),
                child: index,
              );
            }

            //landed piece
            else if (gameBoard[row][col] != null) {
              return Pixel(
                color: Color.fromARGB(255, 191, 1, 1),
                child: '',
              );
            }

            //blank pixel
            else {
              return Pixel(
                color: const Color.fromARGB(255, 83, 83, 83),
                child: index,
              );
            }
          }),
    );
  }
}
