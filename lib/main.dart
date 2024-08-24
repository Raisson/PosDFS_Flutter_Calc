import 'package:flutter/material.dart';

void main() {
  runApp(CalculadoraSimples());
}

class CalculadoraSimples extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculadoraHome(),
    );
  }
}

class CalculadoraHome extends StatefulWidget {
  @override
  _CalculadoraHomeState createState() => _CalculadoraHomeState();
}

class _CalculadoraHomeState extends State<CalculadoraHome> {
  String _displayText = '';
  String _historyText = '';
  String _operator = '';
  double _currentResult = 0;
  bool _operatorSelected = false;

  void _numClick(String text) {
    setState(() {
      if (_operatorSelected) {
        _displayText = text;
        _operatorSelected = false;
      } else {
        _displayText += text;
      }
    });
  }

  void _operatorClick(String text) {
    if (_displayText.isNotEmpty && !_operatorSelected) {
      if (_currentResult == 0) {
        _currentResult = double.parse(_displayText);
      } else {
        _calculateIntermediateResult();
      }
      _operator = text;
      setState(() {
        _historyText += ' $_displayText $_operator';
        _displayText = _currentResult.toString();
        _operatorSelected = true;
      });
    }
  }

  void _calculate() {
    if (_operator.isNotEmpty && !_operatorSelected) {
      _calculateIntermediateResult();
      setState(() {
        _historyText += ' $_displayText = $_currentResult\n';
        _displayText = _currentResult.toString();
        _operator = '';
      });
    }
  }

  void _calculateIntermediateResult() {
    final double currentNumber = double.parse(_displayText);
    switch (_operator) {
      case '+':
        _currentResult += currentNumber;
        break;
      case '-':
        _currentResult -= currentNumber;
        break;
      case '*':
        _currentResult *= currentNumber;
        break;
      case '/':
        _currentResult /= currentNumber;
        break;
    }
  }

  void _clear() {
    setState(() {
      _displayText = '';
      // _historyText = '';
      _operator = '';
      _currentResult = 0;
      _operatorSelected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora Simples'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              _historyText,
              style: TextStyle(fontSize: 24, color: Colors.grey),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              _displayText,
              style: TextStyle(fontSize: 48),
            ),
          ),
          Row(
            children: <Widget>[
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildButton('/'),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildButton('*'),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildButton('-'),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('0'),
              _buildButton('C'),
              _buildButton('='),
              _buildButton('+'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          if (text == 'C') {
            _clear();
          } else if (text == '=') {
            _calculate();
          } else if ('+-*/'.contains(text)) {
            _operatorClick(text);
          } else {
            _numClick(text);
          }
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(20),
          textStyle: TextStyle(fontSize: 24),
        ),
        child: Text(text),
      ),
    );
  }
}
