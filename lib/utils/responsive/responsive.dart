import 'package:flutter/material.dart';

bool isTablet(BuildContext context) {
  // final context = navigatorKey.currentContext!;
  final size = MediaQuery.sizeOf(context);
  final width = size.width;

  if (width > 700) {
    return true;
  } else {
    return false;
  }
}
