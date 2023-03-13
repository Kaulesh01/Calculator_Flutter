import 'package:calculator/ults/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class calculatorscreen extends StatefulWidget {
  const calculatorscreen({super.key});

  @override
  State<calculatorscreen> createState() => _calculatorscreenState();
}

class _calculatorscreenState extends State<calculatorscreen> {
  late String answer = ' ';
  late String question = ' ';
  var p;
  bool theme = true;

  List elements = [
    'AC',
    '+/-',
    ' % ',
    ' ÷ ',
    '7',
    '8',
    '9',
    ' x ',
    '4',
    '5',
    '6',
    ' - ',
    '1',
    '2',
    '3',
    ' + ',
    '<',
    '0',
    '.',
    '='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme ? Color(0xff22252d) : Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      theme = !theme;
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 80,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: theme
                          ? Color.fromARGB(255, 67, 69, 86)
                          : Color.fromARGB(149, 249, 249, 249),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.dark_mode_outlined,
                            color: theme
                                ? Colors.white
                                : Color.fromARGB(255, 162, 161, 161)),
                        SizedBox(width: 10),
                        Icon(Icons.wb_sunny_outlined,
                            color: theme
                                ? Color.fromARGB(255, 85, 85, 85)
                                : Color.fromARGB(255, 50, 50, 50)),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Expanded(
                flex: 0,
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        question,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: theme ? Colors.white : Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        answer,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: theme ? Colors.white : Colors.black,
                          fontSize: 50,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: theme
                        ? Color(0xff2a2d37)
                        : Color.fromARGB(249, 249, 249, 249),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: GridView.builder(
                    itemCount: elements.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return buttons(
                          onPressed: () {
                            setState(() {
                              question = " ";
                              answer = " ";
                            });
                          },
                          text: elements[index],
                          textcolor: Color.fromARGB(255, 114, 235, 172),
                          bgcolor: theme
                              ? Color(0xff2a2d37)
                              : Color.fromARGB(248, 255, 255, 255),
                        );
                      } else if (index == 1) {
                        return buttons(
                          onPressed: () {
                            setState(() {
                              answer += (int.parse(answer) * -1).toString();
                            });
                          },
                          text: elements[index],
                          textcolor: Color.fromARGB(255, 114, 235, 172),
                          bgcolor: theme
                              ? Color(0xff2a2d37)
                              : Color.fromARGB(248, 255, 255, 255),
                        );
                      } else if (index == 3 ||
                          index == 7 ||
                          index == 11 ||
                          index == 15) {
                        return buttons(
                          onPressed: () {
                            setState(() {
                              question += elements[index];
                            });
                          },
                          text: elements[index],
                          textcolor: Color(0xffe84c3d),
                          bgcolor: theme
                              ? Color(0xff2a2d37)
                              : Color.fromARGB(248, 255, 255, 255),
                        );
                      } else if (index == 16) {
                        return buttons(
                          onPressed: () {
                            setState(() {
                              question =
                                  question.substring(0, question.length - 1);
                            });
                          },
                          text: elements[index],
                          textcolor: theme ? Colors.white : Colors.black,
                          bgcolor: theme
                              ? Color(0xff2a2d37)
                              : Color.fromARGB(248, 255, 255, 255),
                        );
                      } else if (index == 19) {
                        return buttons(
                          onPressed: () {
                            setState(() {
                              equalpressed();
                            });
                          },
                          text: elements[index],
                          textcolor: Color(0xffe84c3d),
                          bgcolor: theme
                              ? Color(0xff2a2d37)
                              : Color.fromARGB(248, 255, 255, 255),
                        );
                      } else {
                        return buttons(
                          onPressed: () {
                            setState(() {
                              question = question + elements[index];
                            });
                          },
                          text: elements[index],
                          textcolor: theme ? Colors.white : Colors.black,
                          bgcolor: theme
                              ? Color(0xff2a2d37)
                              : Color.fromARGB(248, 255, 255, 255),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  equalpressed() {
    String finalQuestion = question;
    finalQuestion = finalQuestion.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
  }
}
