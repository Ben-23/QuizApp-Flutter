import 'package:flutter/material.dart';
import 'package:quizapp/questions.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Questions q = Questions();
  int questionIndex;
  int score = 0;
  List<Widget> icList = [];
  void checkans(bool a) {
    bool crctAns = q.questionAns();
    setState(() {
      if (q.isFinished() == true) {
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.\n SCORE $score',
        ).show();
        q.reset();
        score = 0;
        icList = [];
      } else {
        if (crctAns == a) {
          score++;
          icList.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          icList.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        q.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    questionIndex = q.questionNumber;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: 40,
        ),
        Expanded(
          child: Center(
            child: Text(
              'The BBA Quiz',
              style: TextStyle(fontSize: 30.0),
            ),
          ),
        ),
        Expanded(child: Center(child: Text('Answered $questionIndex of 13'))),
        Expanded(
          child: Center(
              child: Text(
            'Question',
            style: TextStyle(fontSize: 20.0),
          )),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                q.questionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 5,
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                checkans(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 5,
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                checkans(false);
              },
            ),
          ),
        ),
        Expanded(
            child: Row(
          children: icList,
        ))
      ],
    );
  }
}
