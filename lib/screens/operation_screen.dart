import 'package:flutter/material.dart';
import 'package:math_for_kids/utilities/widgets/operation_widget.dart';
import 'package:math_for_kids/utilities/generator/number_generator.dart';
import 'package:google_fonts/google_fonts.dart';

class OperationScreen extends StatelessWidget {
  final OperationType operation;

  OperationScreen({required this.operation});

  @override
  Widget build(BuildContext context) {
    String title = '';
    dynamic colorss = '';
    switch (operation) {
      case OperationType.Addition:
        title = "assets/addT.png";
        colorss = Color.fromARGB(255, 148, 184, 0);
        break;
      case OperationType.Subtraction:
        title = "assets/subT.png";
        colorss = Color.fromARGB(255, 2, 188, 244);
        break;
      case OperationType.Multiplication:
        title = "assets/multT.png";
        colorss = Color.fromARGB(255, 242, 187, 26);
        break;
      case OperationType.Division:
        title = "assets/divT.png";
        colorss = Color.fromARGB(255, 233, 66, 116);
        break;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                colorss, // Choose your desired color here
                BlendMode.srcIn,
              ),
              child: Image.asset(
                "assets/arrowB.png",
                width: 150,
                height: 100,
              ), // Replace with your image asset path
            )),
        title: Image.asset(
          title,
          height: 230,
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/gif/bby.gif", // Replace with your background image asset
              fit: BoxFit.cover,
            ),
          ),
          // Animated Container with Tint
          Positioned.fill(
            child: AnimatedContainer(
              duration:
                  Duration(seconds: 5), // Adjust animation duration as needed
              color: Color.fromARGB(83, 158, 156, 156)
                  .withOpacity(0.5), // Adjust tint color and opacity as needed
            ),
          ),
          Center(
            child: OperationWidget(operation: operation),
          ),
        ],
      ),
    );
  }
}
