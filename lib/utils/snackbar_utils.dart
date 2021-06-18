import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String msg) {
  var snackBar = SnackBar(
    content: Text(msg),
    action: SnackBarAction(
        label: "OK", onPressed: () => debugPrint("Undo clicked")),
  );
  Scaffold.of(context).showSnackBar(snackBar);
}
