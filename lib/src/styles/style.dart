import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final Color mainColor = Colors.amber;
final LinearGradient redGColor = LinearGradient(
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
  colors: [
    Colors.red.withOpacity(0.5),
    Colors.red.withOpacity(0.4),
    Colors.red.withOpacity(0.3),
    Colors.red.withOpacity(0.2),
    Colors.red.withOpacity(0.1),
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
  ],
);

final LinearGradient greenGColor = LinearGradient(
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
  colors: [
    Colors.green.withOpacity(0.5),
    Colors.green.withOpacity(0.4),
    Colors.green.withOpacity(0.3),
    Colors.green.withOpacity(0.2),
    Colors.green.withOpacity(0.1),
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
  ],
);

final LinearGradient amberGColor = LinearGradient(
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
  colors: [
    Colors.amber.withOpacity(0.5),
    Colors.amber.withOpacity(0.4),
    Colors.amber.withOpacity(0.3),
    Colors.amber.withOpacity(0.2),
    Colors.amber.withOpacity(0.1),
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
  ],
);
