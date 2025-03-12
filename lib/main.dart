import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Calculator());
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String displayText = '0';
  double numOne = 0;
  double numTwo = 0;
  String result = '';
  String finalResult = '0';
  String operation = '';
  String prevOperation = '';

  void calculation(String btnText) {
    if (btnText == 'AC') {
      displayText = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      operation = '';
      prevOperation = '';
    } else if (operation == '=' && btnText == '=') {
      if (prevOperation == '+') {
        finalResult = add();
      } else if (prevOperation == '-') {
        finalResult = subtract();
      } else if (prevOperation == 'x') {
        finalResult = multiply();
      } else if (prevOperation == '/') {
        finalResult = divide();
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '/' ||
        btnText == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if (operation == '+') {
        finalResult = add();
      } else if (operation == '-') {
        finalResult = subtract();
      } else if (operation == 'x') {
        finalResult = multiply();
      } else if (operation == '/') {
        finalResult = divide();
      }
      prevOperation = operation;
      operation = btnText;
      result = '';
    } else if (btnText == '%') {
      result = (numOne / 100).toString();
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.contains('.')) {
        result += '.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result = result.startsWith('-') ? result.substring(1) : '-' + result;
      finalResult = result;
    } else {
      result += btnText;
      finalResult = result;
    }

    setState(() {
      displayText = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String subtract() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String multiply() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String divide() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0)) return splitDecimal[0];
    }
    return result.toString();
  }

  Widget buildButton(
    String text,
    Color bgColor,
    Color textColor, {
    int flex = 1,
  }) {
    return Expanded(
      flex: flex,
      child: Container(
        margin: EdgeInsets.all(8),
        child: ElevatedButton(
          onPressed: () {
            calculation(text);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            shape: text == '0' ? StadiumBorder() : CircleBorder(),
            padding: EdgeInsets.all(20),
          ),
          child: Text(text, style: TextStyle(fontSize: 30, color: textColor)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('Calculator'), backgroundColor: Colors.black),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.bottomRight,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  displayText,
                  style: TextStyle(color: Colors.white, fontSize: 80),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  buildButton('AC', Colors.grey, Colors.black),
                  buildButton('+/-', Colors.grey, Colors.black),
                  buildButton('%', Colors.grey, Colors.black),
                  buildButton('/', Colors.amber, Colors.white),
                ],
              ),
              Row(
                children: [
                  buildButton('7', Colors.grey[850]!, Colors.white),
                  buildButton('8', Colors.grey[850]!, Colors.white),
                  buildButton('9', Colors.grey[850]!, Colors.white),
                  buildButton('x', Colors.amber, Colors.white),
                ],
              ),
              Row(
                children: [
                  buildButton('4', Colors.grey[850]!, Colors.white),
                  buildButton('5', Colors.grey[850]!, Colors.white),
                  buildButton('6', Colors.grey[850]!, Colors.white),
                  buildButton('-', Colors.amber, Colors.white),
                ],
              ),
              Row(
                children: [
                  buildButton('1', Colors.grey[850]!, Colors.white),
                  buildButton('2', Colors.grey[850]!, Colors.white),
                  buildButton('3', Colors.grey[850]!, Colors.white),
                  buildButton('+', Colors.amber, Colors.white),
                ],
              ),
              Row(
                children: [
                  buildButton('0', Colors.grey[850]!, Colors.white, flex: 2),
                  buildButton('.', Colors.grey[850]!, Colors.white),
                  buildButton('=', Colors.amber, Colors.white),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
