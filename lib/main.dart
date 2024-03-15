import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_for_kids/screens/operation_screen.dart';
import 'package:math_for_kids/utilities/generator/number_generator.dart'; // Import the file where OperationType is defined

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Math For Kids',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MenuScreen(),
    );
  }
}

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              color: Color.fromARGB(255, 202, 197, 197),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: Text("Devs"),
                          content: Container(
                              width: 100,
                              height: 50,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("GIANN ISIDORE LEGASPI"),
                                  Text("HEIDERN V. MONTEJO"),
                                ],
                              )),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("EXIT!"))
                          ],
                        ));
              },
              icon: Icon(Icons.info))
        ],
      ),
      body: Stack(
        children: [
          // Background Image
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
              // color: Color.fromARGB(116, 89, 85, 85)
              //     .withOpacity(0.5), // Adjust tint color and opacity as needed
            ),
          ),
          // Menu Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/title.png",
                  height: 300,
                ),
                SizedBox(height: 40),
                // Button Rows...
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          createGesture(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OperationScreen(
                                        operation: OperationType.Addition)));
                          }, "assets/add.png"),
                          SizedBox(height: 20),
                          createGesture(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OperationScreen(
                                        operation: OperationType.Subtraction)));
                          }, "assets/min.png"),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          createGesture(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OperationScreen(
                                        operation:
                                            OperationType.Multiplication)));
                          }, "assets/mul.png"),
                          SizedBox(height: 20),
                          createGesture(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OperationScreen(
                                        operation: OperationType.Division)));
                          }, "assets/div.png"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget createGesture(VoidCallback ontap, String x) {
    return GestureDetector(
      child: Image.asset(x, height: 150),
      onTap: ontap,
    );
  }
}
