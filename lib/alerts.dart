import 'package:flutter/cupertino.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class Alerts {
  BuildContext context;

  void showLoading(BuildContext context, String text) {
    this.context = context;
    showAnimatedDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ClassicGeneralDialogWidget(
          titleText: text,
          //contentText: 'content',
        );
      },
      animationType: DialogTransitionType.slideFromBottomFade,
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 300),
    );
  }

  void showAlert(BuildContext context, String text) {
    this.context = context;
    showAnimatedDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ClassicGeneralDialogWidget(
          titleText: text,
          onPositiveClick: () {
            this.dismissContext();
          },
        );
      },
      animationType: DialogTransitionType.slideFromBottomFade,
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 300),
    );
  }

  void dismissContext() {
    if (context != null) {
      Navigator.pop(context);
      context = null;
    }
  }
}
