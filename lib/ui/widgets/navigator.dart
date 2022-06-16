import 'package:flutter/cupertino.dart';

class NavigatorPop {
  final BuildContext context;

  NavigatorPop(this.context) {
    pop(context);
  }

  pop(ctx) {
    Navigator.of(ctx).pop();
  }
}
