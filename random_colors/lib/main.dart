import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const RandomColorsApp());
}

class RandomColorsApp extends StatefulWidget {
  const RandomColorsApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RandomColorsApp();
  }
}

class _RandomColorsApp extends State<RandomColorsApp> {
  final List<Color> _colors = [];
  int _count = 0;

  addColor() {
    setState(() {
      _count++;
      _colors.add(
          Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0));
    });
  }

  removeColor() {
    setState(() {
      if (_count != 0) {
        _count--;
      }
      if (_colors.isNotEmpty) {
        _colors.removeLast();
      }
    });
  }

  changeColor(int index) {
    setState(() {
      _colors[index] =
          Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Random Colors"),
        ),
        body: Stack(
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: ButtonBar(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      MaterialButton(
                        height: 40.0,
                        color: Colors.blue,
                        onPressed: () {
                          addColor();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text('Add'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                        child: MaterialButton(
                          height: 40.0,
                          color: Colors.blue,
                          onPressed: () {
                            for (int i = 0; i < _colors.length; i++) {
                              changeColor(i);
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text('Change all colors'),
                          ),
                        ),
                      ),
                      MaterialButton(
                        height: 40.0,
                        color: Colors.red,
                        onPressed: () {
                          removeColor();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text('Remove'),
                        ),
                      ),
                    ],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
              child: GridView(
                padding: const EdgeInsets.all(24),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                children: [
                  for (int i = 0; i < _colors.length; i++)
                    InkWell(
                      child: Container(
                        color: _colors[i],
                        child: Center(
                          child: Text(
                            "#${i + 1} RGB(${_colors[i].red}, ${_colors[i].green}, ${_colors[i].blue})",
                            style: const TextStyle(
                              fontSize: 30.0,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        changeColor(i);
                      },
                    ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Total elements: ${_colors.length}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
