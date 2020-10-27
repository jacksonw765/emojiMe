import 'package:flutter/cupertino.dart';
import 'package:ndialog/ndialog.dart';

class Alerts {
  BuildContext context;

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
