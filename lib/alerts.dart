import 'package:flutter/cupertino.dart';
import 'package:ndialog/ndialog.dart';

import 'chars.dart';

class Alerts {
  BuildContext context;

  void showChars(BuildContext context) async {
    List<Widget> buildRows() {
      List<Widget> retval = [];
      for (int x = 0; x < Char.CHARS.length; x += 4) {
        if (Char.CHARS.length > x + 3) {
          retval.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CharWidget2(char: Char.CHARS[x]),
              CharWidget2(char: Char.CHARS[x + 1]),
              CharWidget2(char: Char.CHARS[x + 2]),
              CharWidget2(char: Char.CHARS[x + 3]),
            ],
          ));
        } else if (Char.CHARS.length > x + 2) {
          retval.add(Row(
            children: [
              CharWidget2(char: Char.CHARS[x]),
              CharWidget2(char: Char.CHARS[x + 1]),
              CharWidget2(char: Char.CHARS[x + 2]),
            ],
          ));
        } else if (Char.CHARS.length > x + 1) {
          retval.add(Row(
            children: [
              CharWidget2(char: Char.CHARS[x]),
              CharWidget2(char: Char.CHARS[x + 1]),
            ],
          ));
        } else {
          retval.add(Row(
            children: [
              CharWidget2(char: Char.CHARS[x]),
            ],
          ));
        }
      }
      return retval;
    }

    await NDialog(
      dialogStyle: DialogStyle(titleDivider: true,),
      title: Text("Select Emoji"),
      content: Container(
        height: 450,
        width: 450,
        child: ListView(
          children: buildRows(),
        ),
      ),
      //actions: <Widget>[],
    ).show(context);
  }

  void showLoading(BuildContext context) async {
    await NDialog(
      dialogStyle: DialogStyle(titleDivider: true),
      title: Text("Loading..."),
      //content: Text("And here is your content, hoho... "),
      //actions: <Widget>[],
    ).show(context);
  }

  void dismissContext() {
    if (context != null) {
      Navigator.pop(context);
      context = null;
    }
  }
}
