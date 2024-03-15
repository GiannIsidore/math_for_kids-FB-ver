import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:math_for_kids/utilities/generator/number_generator.dart';
import 'dart:math';

class OperationWidget extends StatefulWidget {
  final OperationType operation;

  OperationWidget({required this.operation});

  @override
  _OperationWidgetState createState() => _OperationWidgetState();
}

class _OperationWidgetState extends State<OperationWidget> {
  int numStars = 0;
  int numLives = 3;
  late List<int> numbers;
  late int correctAnswer;

  @override
  void initState() {
    super.initState();
    generateNewNumbers();
  }

  void generateNewNumbers() {
    setState(() {
      numbers = NumberGenerator.generateNumbersForOperation(widget.operation);
      correctAnswer = calculateCorrectAnswer(numbers, widget.operation);
    });
  }

  void checkAnswer(int selectedAnswer) {
    if (selectedAnswer == correctAnswer) {
      setState(() {
        numStars = (numStars < 5) ? numStars + 1 : numStars;
      });
      showSnackBar('Correct!', Colors.green);
      if (numStars == 5) {
        showCompletionDialog();
      }
    } else {
      setState(() {
        numLives = (numLives > 0) ? numLives - 1 : numLives;
      });
      showSnackBar('Incorrect!', Colors.red);
      if (numLives == 0) {
        showFailureDialog();
      }
    }
    generateNewNumbers();
  }

  void showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: Duration(seconds: 1),
      ),
    );
  }

  String getOperationSymbol(OperationType operation) {
    switch (operation) {
      case OperationType.Addition:
        return '+';
      case OperationType.Subtraction:
        return '-';
      case OperationType.Multiplication:
        return '×';
      case OperationType.Division:
        return '÷';
    }
  }

  int calculateCorrectAnswer(List<int> numbers, OperationType operation) {
    switch (operation) {
      case OperationType.Addition:
        return numbers[0] + numbers[1];
      case OperationType.Subtraction:
        return numbers[0] - numbers[1];
      case OperationType.Multiplication:
        return numbers[0] * numbers[1];
      case OperationType.Division:
        return (numbers[0] ~/ numbers[1]); // Use integer division
    }
  }

  void showCompletionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(getRandomCompliment()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('You scored $numStars stars!'),
              SizedBox(height: 10),
              Text('Incorrect answers: ${3 - numLives}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetGame();
              },
              child: Text('Retry'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text('Menu'),
            ),
          ],
        );
      },
    );
  }

  void showFailureDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(getRandomFailureMessage()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetGame();
              },
              child: Text('Retry'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text('Menu'),
            ),
          ],
        );
      },
    );
  }

  String getRandomCompliment() {
    final compliments = [
      'Great job!',
      'Well done!',
      'Fantastic!',
      'You\'re amazing!',
      'Outstanding performance!',
    ];
    return compliments[Random().nextInt(compliments.length)];
  }

  String getRandomFailureMessage() {
    final messages = [
      'Better luck next time!',
      'You still did great!',
      'Don\'t give up!',
      'Keep practicing!',
    ];
    return messages[Random().nextInt(messages.length)];
  }

  void resetGame() {
    setState(() {
      numStars = 0;
      numLives = 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    dynamic colorss;
    switch (OperationType) {
      case OperationType.Addition:
        colorss = Color.fromARGB(255, 148, 184, 0);
        break;
      case OperationType.Subtraction:
        colorss = Color.fromARGB(255, 2, 188, 244);
        break;
      case OperationType.Multiplication:
        colorss = Color.fromARGB(255, 242, 187, 26);
        break;
      case OperationType.Division:
        colorss = Color.fromARGB(255, 233, 65, 116);
        break;
    }
    // Shuffle the positions to randomize the order
    List<int> positions = [0, 1, 2]..shuffle();

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(
                    numStars,
                    (index) => Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 50,
                    ),
                  ),
                ),

                // Life counter with hearts
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: List.generate(
                    numLives,
                    (index) => Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 50,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 200,
          ),
          Column(
            children: [
              Text(
                '${numbers[0]} ${getOperationSymbol(widget.operation)} ${numbers[1]} = ?',
                style: GoogleFonts.concertOne(
                  fontSize: 78,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20.0),
              // Buttons for answers
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 3; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal:
                              8.0), // Adjust the horizontal space as needed
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                        ),
                        onPressed: () {
                          checkAnswer(correctAnswer - 1 + positions[i]);
                        },
                        child: Container(
                          child: Text(
                            '${correctAnswer - 1 + positions[i]}',
                            style: GoogleFonts.openSans(
                              fontSize: 38,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          // Progress bar for stars
        ],
      ),
    );
  }
}
