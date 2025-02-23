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
  String? _firstNum;
  String? _secondNum;
  String? _operator;
  String? _equation;
  int _result = 0;

  _setNumber(String num) {
    setState( () {
      // Able to add numbers to _firstNum if the operator isn't set
      if (_operator != null) {
        _secondNum != null ? _secondNum = '$_secondNum$num' : _secondNum = num;
      } else {
        _firstNum != null ? _firstNum = '$_firstNum$num' : _firstNum = num;
      }
    });
  }

  _setOperator(String operator) {
    setState(() {
      _operator = operator;
      //_setEquation();
    });
  }

  /*_setEquation() {
    setState(() {
      _equation = '$_firstNum $_operator $_secondNum';
    });
  }*/

  _solveEquation() {
    setState(() {
      if (_firstNum != null && _operator != null && _secondNum != null) {
        int first = int.tryParse(_firstNum!) ?? 0;
        int second = int.tryParse(_secondNum!) ?? 0;
        if (_operator! == '+') {
          _result = first + second;
        } else if (_operator! == '-') {
          _result = first - second;
        } else if (_operator! == '*') {
          _result = first * second;
        } else if (_operator! == '/' && second !=0) {
          _result = first ~/ second;
        }
      } else {
        _result = 1;
      }
    });
  }

  void _clearButton() {
    setState(() {
      _firstNum = null;
      _secondNum = null;
      _operator = null;
      _result = 0;
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
            Text(
              _firstNum ?? ''
            ),
            Text(
              _operator ?? ''
            ),
            Text(
              _secondNum ?? ''
            ),
            Text(
              _result.toString()
            ),
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
