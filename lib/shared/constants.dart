import 'package:flutter/material.dart';

class Constants {
  // Public URLs served by Vercel’s /public folder
  static const String coinHeadsUrl = '/assets/images/heads.png';
  static const String coinTailsUrl = '/assets/images/tails.png';

  // Common padding
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 24,
  );

  // Text styles
  static const TextStyle titleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle labelStyle = TextStyle(fontSize: 16);

  // Theme colors
  static const Color primaryColor = Colors.blueAccent;
  static const Color accentColor = Colors.orangeAccent;
}
