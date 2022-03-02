import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  String _theState = "0";
  int _actualWordType = 0;
  int _score = 0;
  var _textcolor = Colors.blue;
  final _random = new Random();

  int next(int min, int max) => min + _random.nextInt(max - min);

  @override
  void initState() {
    super.initState();
    setRandomWord();
  }

  void setRandomWord() {
    var option = next(0, 2);
    _actualWordType = option;
    print(_actualWordType);
    if (option == 0) {
      print("change to noun");
      _theState = (nouns.toList()..shuffle()).first;
    } else {
      print("change to adjective");
      _theState = (adjectives.toList()..shuffle()).first;
    }
  }

  void _onPressed(int option) {
    setState(() {
      if (_actualWordType == option) {
        _textcolor= Colors.blue;
        setRandomWord();
        _score++;
      } else {
        _textcolor= Colors.red;
        setRandomWord();
        _score--;
      }
    });
  }

  void _onReset() {
    setState(() {
      _textcolor= Colors.blue;
      _score = 0;
      setRandomWord();
    });
  }

  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Random Words"),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,G
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Score: $_score",
                style: const TextStyle(fontSize: 17),
              ),
            )
          ]),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 80, 20, 40),
            child: Text(
              _theState.toUpperCase(), //--------------------------------------
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  height: 200.0,
                  width: 135.0,
                  child: ElevatedButton(
                      onPressed: () => _onPressed(0),
                      style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(_textcolor),
                      ),
                      child: const Text(
                        "Noun",
                        style: TextStyle(color: Colors.amber, fontSize: 19),
                        )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                    height: 200.0,
                    width: 135.0,
                    child: ElevatedButton(
                        onPressed: () => _onPressed(1),
                        style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(_textcolor),
                        ),
                        child: const Text(
                          "Adjective",
                          style: TextStyle(color: Colors.amber, fontSize: 19),
                          ))),
              ),
            ],
          ),
          Align(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: ElevatedButton(
                onPressed: () => _onReset(), child: const Text(
                  "Reset",
                  style: TextStyle(color: Colors.amber, fontSize: 15),
                  )),
          ),
        )
        ],
      ),
    );
  }
}
