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

  //game over status
  bool gameOver = false;

  @override
  void initState() {
    super.initState();
    //start game when app starts
    startGame();
  }

  void startGame() {
    currentPiece.intializePiece();

    //frame refresh rate
    Duration frameRate = const Duration(milliseconds: 500);
    gameLoop(frameRate);
  }

  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
        checkLanding();

        //check if game over
        if (gameOver == true) {
          timer.cancel();
          showGameOverDialog();
        }

        currentPiece.movePiece(Direction.down);
      });
    });
  }

  //game over message dialog
  void showGameOverDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Game Over"),
              content: Text("Score: $currentPiece.score"),
              actions: [
                TextButton(
                    onPressed: () {
                      resetGame();
                      Navigator.pop(context);
                    },
                    child: Text("Play Again"))
              ],
            ));
  }

  //reset Game
  void resetGame() {
    //clear the game board
    gameBoard = List.generate(
        columnLength, (i) => List.generate(rowLength, (j) => null));

    // new game
    gameOver = false;
    currentScore = 0;

    //create new piece
    createNewPiece();

    //start game
    startGame();
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
      currentScore++;
    }
  }

  //GAME OVER MESSAGE
  bool isGameOver() {
    //check if any columns in the top row is fill
    for (int col = 0; col < rowLength; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }

    // if the top row is empty return false
    return false;
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

    if (isGameOver()) {
      gameOver = true;
    }
  }

  //move left
  void moveLeft() {
    //to make sure before moving the piece check if there is a collision
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  //move right
  void moveRight() {
    //to make sure before moving the piece check if there is a collision
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  //rotate piece
  void rotatePiece() {
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 32, 28, 28),
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 57, 53, 74),
          centerTitle: true,
          title: Text("Tetris")),
      body: Column(
        children: [
          Expanded(
            //GAME SCREEN
            child: GridView.builder(
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
                    final Tetromino? tetrominoType = gameBoard[row][col];
                    return Pixel(
                      color: tetrominoColors[tetrominoType]!,
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
          ),

          //GAME CONTROLS
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //left
                IconButton(
                  onPressed: moveLeft,
                  icon: Icon(Icons.arrow_back_ios_new_outlined),
                  color: Colors.white,
                ),
                //rotate
                IconButton(
                    onPressed: rotatePiece,
                    icon: Icon(Icons.rotate_right),
                    color: Colors.white),
                //right
                IconButton(
                    onPressed: moveRight,
                    icon: Icon(Icons.arrow_forward_ios_outlined),
                    color: Colors.white),
              ],
            ),
          )
        ],
      ),
    );
  }
}
