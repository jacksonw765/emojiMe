import 'package:flutter/material.dart';

class Styles {
  static BoxShadow topShadow = BoxShadow(spreadRadius: 1, color: Colors.grey[500],
      blurRadius: 15, offset: Offset(4, 4));
  static BoxShadow bottomShadow = BoxShadow(spreadRadius: 1, color: Colors.white,
      blurRadius: 15, offset: Offset(-4, -4));
}
