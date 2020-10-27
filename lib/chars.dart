import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class Char {
  static const CHARS = "∂∆∏∑−√∞∫≈≠≤≥◊☀☁☂☃☄★☆☇☈☉☊☋☌☍☎☏☐☑☒☓☔☕☖☗☘☙☚☛☜☝☞☟☠☡☢☣☤☥☦☧☨☩☪☫☬☭☮☯☰☱☲☳☴☵☶☷"
      "☸☹☺☻☽☾☿♀♁♂♃♄♅♆♇♈♉♊♋♌♍♎♏♐♑♒♓♔♕♖♗♘♙♚♛♜♝♞♟♠♡♢♣♤♥♦♧♨♩♪♫♬♭♮♯♰♱♲♳♴♵♶♷♸♹♺♻♼♽♾♿⚀⚁⚂⚃⚄⚅⚆⚇⚈⚉⚊⚋⚌⚍⚎⚏⚐"
      "⚑⚒⚓⚔⚕⚖⚗⚘⚙⚚⚛⚜⚝⚞⚟⚠⚡⚢⚣⚤⚥⚦⚧⚨⚩⚪⚫⚬⚭⚮⚯⚰⚱⚲⚳⚴⚵⚶⚷⚸⚹⚺⚻⚼⚽⚾⚿⛀⛁⛂⛃⛄⛅⛆⛇⛈⛉⛊⛋⛌⛍⛎⛏⛐⛑⛒⛓⛔⛕⛖⛗⛘⛙⛚⛛⛜⛝⛞⛟⛠⛡⛢⛣⛤⛥⛦⛧"
      "⛨⛩⛪⛫⛬⛭⛮⛯⛰⛱⛲⛳⛴⛵⛶⛷⛸⛹⛺⛻⛼⛽⛾";
  static String selectedChar = "⛹";
}

class SelectEmojiWidget extends StatefulWidget {
  @override
  _SelectEmojiWidgetState createState() => _SelectEmojiWidgetState();
}

class _SelectEmojiWidgetState extends State<SelectEmojiWidget> {
  final shadow2 = BoxShadow(spreadRadius: -20, color: Colors.black45, blurRadius: 20, offset: Offset(0, 14));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 25, left: 15, right: 15, bottom: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [shadow2],
        ),
        child: Column(children: [
          Text(
            'Emoji',
            style: TextStyle(color: Colors.blue, fontSize: 18),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Spacer(
                  flex: 4,
                ),
                Text(
                  Char.selectedChar,
                  style: TextStyle(fontSize: 28),
                ),
                Spacer(
                  flex: 10,
                ),
                FlatButton(
                  onPressed: () => showChars(context),
                  child: Text(
                    'Select',
                    style: TextStyle(color: Colors.blue, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  void showChars(BuildContext context) async {
    List<Widget> buildRows() {
      List<Widget> retval = [];
      retval.add(Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 10),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.black,
              iconSize: 20,
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Spacer(flex: 30),
          Text(
            'Select Emoji',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          Spacer(flex: 50),
        ],
      ));
      for (int x = 0; x < Char.CHARS.length; x += 4) {
        if (Char.CHARS.length > x + 3) {
          retval.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              charWidget(Char.CHARS[x]),
              charWidget(Char.CHARS[x + 1]),
              charWidget(Char.CHARS[x + 2]),
              charWidget(Char.CHARS[x + 3]),
            ],
          ));
        } else if (Char.CHARS.length > x + 2) {
          retval.add(Row(
            children: [
              charWidget(Char.CHARS[x]),
              charWidget(Char.CHARS[x + 1]),
              charWidget(Char.CHARS[x + 2]),
            ],
          ));
        } else if (Char.CHARS.length > x + 1) {
          retval.add(Row(
            children: [
              charWidget(Char.CHARS[x]),
              charWidget(Char.CHARS[x + 1]),
            ],
          ));
        } else {
          retval.add(Row(
            children: [
              charWidget(Char.CHARS[x]),
            ],
          ));
        }
      }
      return retval;
    }

    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Container(
              //color: Colors.white,
              //height: 450,
              //width: 450,
              child: ListView(
                children: buildRows(),
              ),
            ),
          ),
        );
      },
      animationType: DialogTransitionType.slideFromBottomFade,
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 300),
    );
  }

  Widget charWidget(String char) {
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
              char,
              style: TextStyle(fontSize: 32, color: Colors.black),
            ),
          ),
        ),
      ),
      onTap: () {
        print('here');
        Char.selectedChar = char;
        setState(() {});
        Navigator.pop(context);
      },
    );
  }
}
