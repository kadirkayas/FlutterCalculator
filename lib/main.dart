import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String number = '';
  String result = "";
  String clickedButton = '';
  String process ='';
  var numbers = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '00','X','/','+','-'};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text("Calculator"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
              margin: EdgeInsets.all(20),
              child: Text(number,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),),
              alignment: Alignment.centerRight),
          Container(
            margin: EdgeInsets.all(25),
            child: Text(result,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300)),
            alignment: Alignment.centerRight,
          ),
          Expanded(child: Divider()),
          buildRow('C', '%', 'Delete', '/'),
          buildRow('7', '8', '9', 'X'),
          buildRow('4', '5', '6', '-'),
          buildRow('1', '2', '3', '+'),
          buildRow('00', '0', ',', '='),
        ],
      ),
    );
  }

  Widget buildButton(String buttonName) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white
      ),
      width: MediaQuery.of(context).size.width * .23,
      height: MediaQuery.of(context).size.height * .11,
      margin: EdgeInsets.all(2),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(20),
          primary: Colors.black26,
          onPrimary: Colors.white,

        ),
        onPressed: () {
          setState(() {
            numbers.forEach((element) {
              if (element == buttonName) {
                number += buttonName;
              }
            });
            if ('C' == buttonName) {
              number = '';
              process='';
              result='';
            }
            else if ('Delete' == buttonName) {
              number = number.substring(0,number.length-1);
            }
            else if ('%' == buttonName) {
              var num=int.parse(number);
              assert(num is int);
              result=(num/100).toString();
            }
            else if ('=' == buttonName) {
              process = number;
              process = process.replaceAll('X', '*');
              process = process.replaceAll('/', '/');

              try{
                Parser p = Parser();
                Expression exp = p.parse(process);

                ContextModel cm = ContextModel();
                result = '${exp.evaluate(EvaluationType.REAL, cm)}';
              }catch(e){
                result = "Error";
              }
            }
          });
        },
        child: Text(buttonName),
      ),
    );
  }

  Widget buildRow(String first, String second, String third, String fourth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildButton(first),
        buildButton(second),
        buildButton(third),
        buildButton(fourth),
      ],
    );
  }
}
