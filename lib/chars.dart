import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Char {
  static const CHARS = "∂∆∏∑−√∞∫≈≠≤≥◊☀☁☂☃☄★☆☇☈☉☊☋☌☍☎☏☐☑☒☓☔☕☖☗☘☙☚☛☜☝☞☟☠☡☢☣☤☥☦☧☨☩☪☫☬☭☮☯☰☱☲☳☴☵☶☷"
      "☸☹☺☻☽☾☿♀♁♂♃♄♅♆♇♈♉♊♋♌♍♎♏♐♑♒♓♔♕♖♗♘♙♚♛♜♝♞♟♠♡♢♣♤♥♦♧♨♩♪♫♬♭♮♯♰♱♲♳♴♵♶♷♸♹♺♻♼♽♾♿⚀⚁⚂⚃⚄⚅⚆⚇⚈⚉⚊⚋⚌⚍⚎⚏⚐"
      "⚑⚒⚓⚔⚕⚖⚗⚘⚙⚚⚛⚜⚝⚞⚟⚠⚡⚢⚣⚤⚥⚦⚧⚨⚩⚪⚫⚬⚭⚮⚯⚰⚱⚲⚳⚴⚵⚶⚷⚸⚹⚺⚻⚼⚽⚾⚿⛀⛁⛂⛃⛄⛅⛆⛇⛈⛉⛊⛋⛌⛍⛎⛏⛐⛑⛒⛓⛔⛕⛖⛗⛘⛙⛚⛛⛜⛝⛞⛟⛠⛡⛢⛣⛤⛥⛦⛧"
      "⛨⛩⛪⛫⛬⛭⛮⛯⛰⛱⛲⛳⛴⛵⛶⛷⛸⛹⛺⛻⛼⛽⛾";

  static String selectedChar = "⛹";
}

/*
class CharSelect extends StatefulWidget {
  @override
  _CharSelectState createState() => _CharSelectState();
}

class _CharSelectState extends State<CharSelect> {
  @override
  Widget build(BuildContext context) {
    //double width = MediaQuery.of(context).size.width;
    //int count = (width / 80).floor();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          child: ListView(
            children: buildRows(),
          ),
        ),
      ),
    );
  }

  List<Widget> buildRows() {
    List<Widget> retval = [];
    for (int x = 0; x < Char.CHARS.length; x += 4) {
      if (Char.CHARS.length > x + 3) {
        retval.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CharWidget(char: Char.CHARS[x]),
            CharWidget(char: Char.CHARS[x + 1]),
            CharWidget(char: Char.CHARS[x + 2]),
            CharWidget(char: Char.CHARS[x + 3]),
          ],
        ));
      } else if (Char.CHARS.length > x + 2) {
        retval.add(Row(
          children: [
            CharWidget(char: Char.CHARS[x]),
            CharWidget(char: Char.CHARS[x + 1]),
            CharWidget(char: Char.CHARS[x + 2]),
          ],
        ));
      } else if (Char.CHARS.length > x + 1) {
        retval.add(Row(
          children: [
            CharWidget(char: Char.CHARS[x]),
            CharWidget(char: Char.CHARS[x + 1]),
          ],
        ));
      } else {
        retval.add(Row(
          children: [
            CharWidget(char: Char.CHARS[x]),
          ],
        ));
      }
    }
    return retval;
  }
}

 */

class CharWidget2 extends StatefulWidget {
  final String char;

  CharWidget2({Key key, this.char}) : super(key: key);

  @override
  _CharWidget2State createState() => _CharWidget2State(char);
}

class _CharWidget2State extends State<CharWidget2> {
  //_CharWidget2State({Key key, @required this.char}) : super(key: key);
  final char;
  final shadow2 = BoxShadow(spreadRadius: -20, color: Colors.black45, blurRadius: 20, offset: Offset(0, 14));

  _CharWidget2State(this.char);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 85,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: [shadow2],
            color: Colors.white,
          ),
          child: Center(
            child: Text(
              this.char,
              style: TextStyle(fontSize: 32, color: Colors.black),
            ),
          ),
        ),
      ),
      onTap: () {
        setState(() {
          Char.selectedChar = this.char;
        });
        Navigator.pop(context);
      },
    );
  }
}

class CharWidget extends StatelessWidget {
  CharWidget({Key key, @required this.char}) : super(key: key);
  final char;
  final shadow2 = BoxShadow(spreadRadius: -20, color: Colors.black45, blurRadius: 20, offset: Offset(0, 14));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 85,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: [shadow2],
            color: Colors.white,
          ),
          child: Center(
            child: Text(
              this.char,
              style: TextStyle(fontSize: 32, color: Colors.black),
            ),
          ),
        ),
      ),
      onTap: () {
        Char.selectedChar = this.char;
        Navigator.pop(context);
      },
    );
  }
}
