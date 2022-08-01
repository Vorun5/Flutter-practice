import 'package:flutter/material.dart';

class MyStatelessWidget extends StatelessWidget{
  final String myText;
  final Color myColor;
  const MyStatelessWidget(this.myText, this.myColor, { Key ?key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Text(
      myText,
      style: TextStyle(fontSize: 22, color: myColor),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
  }
}