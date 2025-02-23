import 'package:flutter/material.dart';
/*
  Homework 02 - Calculator App - Myla Newby
    Implement a UI w numbers [0-9], arithmetic operators (+ - * /) and display area
      use widgets like container, column, row, flatbutton/inkwell
    Enable add/sub/mult/div -> display in display area
    Handle calculations w 2 operands and 1 operator (aka _ + _)
    Implement a "clear" button 
    Handle edge cases like dividing w 0 
    Submit apk, main.dart, and word doc = rationale behind implem (+challenges) w github link

    ______
    7 8 9 /
    4 5 6 * 
    1 2 3 - 
    C   = +
 */

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'My Calculator App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Individual parts of the display aka the operands (nums) and operators
  // Can be null just to check if previous parts of the equation need to be updated
  String? _firstNum;
  String? _secondNum;
  String? _operator;
  // The actual display
  String _equation = "";
  // The numerical result
  // Can be null to check if the display can be updated
  int? _result;

  // Creates the number operands, allowing the user to create multi-digit operands
  _setNumber(String num) {
    setState(() {
      // Ensures the user presses the clear button before entering another equation
      if (_result == null) {
        // Only adds _secondNum numbers if the _firstNum isn't set
        if (_operator != null) {
          _secondNum != null ? _secondNum = '$_secondNum$num' : _secondNum = num;
        } else {
          _firstNum != null ? _firstNum = '$_firstNum$num' : _firstNum = num;
        }
        // Updates the display
        _setEquation();
      }
    });
  }
  // Sets the operand
  _setOperator(String operator) {
    setState(() {
      // Ensures the user presses the clear button before entering another equation
      if (_result == null) {
        _operator = operator;
        // Updates the display
        _setEquation();
      }
    });
  }

  // Calculates the result of the operands
  _solveEquation() {
    setState(() {
      // Ensures no null numbers are involved in calculations
      // tryParse() returns null for invalid inputs, which will become 0 here
      int first = int.tryParse(_firstNum!) ?? 0;
      int second = int.tryParse(_secondNum!) ?? 0;
      // Ensures each calculation is handled
      if (_operator! == '+') {
        _result = first + second;
      } else if (_operator! == '-') {
        _result = first - second;
      } else if (_operator! == '*') {
        _result = first * second;
      // Prevents division by 0 error
      } else if (_operator! == '/' && second !=0) {
        _result = first ~/ second;
      }
      // Displays the result to the screen
      _equation = _result.toString();
    });
  }

  // Sets the _equation operand, which displays to the screen
  _setEquation() {
    setState(() {
      // Prevents displaying "null" and displays nothing instead
      String first = _firstNum ?? '';
      String second = _secondNum ?? '';
      String operator = _operator ?? '';

      // Handles displaying each equation part separately
      if (_secondNum != null) {
        _equation = '$first $operator $second';
      } else if (_operator != null) {
        _equation = '$first $operator';
      } else if (_firstNum != null) {
        _equation = first;
      } else {
        _equation = "";
      }
    });
  }

  // Sets nullable variables to null and the display to nothing
  void _clearButton() {
    setState(() {
      _firstNum = null;
      _secondNum = null;
      _operator = null;
      _result = null;
      _equation = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Displays the current equation
            Text(
              _equation
            ),
            // 7 8 9 / Row
            Row( 
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: Text('7'),
                  onPressed: () => _setNumber('7'),
                ),
                ElevatedButton(
                  child: Text('8'),
                  onPressed: () => _setNumber('8'),
                ),
                ElevatedButton(
                  child: Text('9'),
                  onPressed: () => _setNumber('9'),
                ),
                ElevatedButton(
                  child: Text('÷'),
                  onPressed: () => _setOperator('/'),
                ),
                ElevatedButton(
                  child: Text('='), 
                  onPressed: () => _solveEquation(),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _clearButton,
        tooltip: 'Clear',
      ),
    );
  }
}
