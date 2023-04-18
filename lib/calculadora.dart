import 'package:calculator_flutter_basic/buttonlist.dart';
import 'package:calculator_flutter_basic/color_button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String userInput = "";
  String result = "0";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black12,
        body: Column(
          children: [
            Flexible(flex: 1, child: resultwidget()),
            Flexible(
              flex: 4,
              child: buttonswidget(),
            ),
          ],
        ),
      ),
    );
  }

  Widget resultwidget() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerRight,
          child: Text(
            userInput,
            style: TextStyle(
              color: Colors.white,
              fontSize: 33,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerRight,
          child: Text(
            result,
            style: TextStyle(
                color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget buttonswidget() {
    return GridView.builder(
      itemCount: buttonsList.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      itemBuilder: (BuildContext context, int index) {
        return button(buttonsList[index]);
      },
    );
  }

  Widget button(String text) {
    return Container(
      margin: EdgeInsets.all(8),
      child: MaterialButton(
        onPressed: () {
          setState(() {
            handleButtomPress(text);
          });
        },
        color: getcolor(text),
        textColor: Colors.white,
        shape: CircleBorder(),
        child: Text(
          text,
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }

  handleButtomPress(String text) {
    if (text == "+/-") {
      double value;
      value = double.parse(userInput) * (-1);
      userInput = value.toString();
      return;
    }

    if (text == "AC") {
      //Reseta All
      userInput = "";
      result = "0";
      return;
    }
    if (text == "C") {
      //Remove o ultimo char
      userInput = userInput.substring(0, userInput.length - 1);
      if (userInput.length < 1) {
        userInput = " ";
      }
      return;
    }
    if (text == "=") {
      //Calcula o resultado
      result = calculate();
      // Removendo o descimal do resultado
      if (result.endsWith(".0")) result = result.replaceAll(".0", "");
      return;
    }

    userInput = userInput + text;
  }

  String calculate() {
    try {
      var exp = Parser().parse(userInput);
      var evolucao = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evolucao.toString();
    } catch (e) {
      return "Error";
    }
  }
}
