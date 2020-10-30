import 'dart:math';

import 'package:emojieme/styles.dart';
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30, left: 15, right: 15, bottom: 5),
      child: Container(
        constraints: BoxConstraints(
            maxWidth: 350
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [Styles.topShadow, Styles.bottomShadow],
        ),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 7.0),
            child: Text(
              'Emoji',
              style: TextStyle(color: Colors.blue, fontSize: 18),
            ),
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
                  style: TextStyle(fontSize: 32),
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
            child: Transform.rotate(
              angle: pi/4,
              child: IconButton(
                icon: Icon(Icons.add_circle_outline_rounded),
                color: Colors.black,
                iconSize: 25,
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          //Spacer(flex: 30),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              'Select Emoji',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
          //Spacer(flex: 50),
        ],
      ));
      for (int x = 0; x < Char.CHARS.length; x += 3) {
         if (Char.CHARS.length > x + 2) {
          retval.add(Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              charWidget(Char.CHARS[x]),
              charWidget(Char.CHARS[x + 1]),
              charWidget(Char.CHARS[x + 2]),
            ],
          ));
        } else if (Char.CHARS.length > x + 1) {
          retval.add(Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              charWidget(Char.CHARS[x]),
              charWidget(Char.CHARS[x + 1]),
            ],
          ));
        } else {
          retval.add(Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              charWidget(Char.CHARS[x]),
            ],
          ));
        }
      }
      return retval;
    }

    showDialog(
        context: context,
        builder: (_) =>
        new AlertDialog(
          contentPadding: EdgeInsets.all(0.0),
          content: Container(
            height: 400,
            width: 400,
            child: ListView(
                children: buildRows(),
            ),
          ),
        )
    );

  }

  Widget charWidget(String char) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0, bottom: 12, left: 15, right: 15),
        child: Container(
          height: 85,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(17)),
            boxShadow: [Styles.topShadow, Styles.bottomShadow],
            color: Colors.white,
          ),
          child: Center(
            child: Text(
              char,
              style: TextStyle(fontSize: 30, color: Colors.black),
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
