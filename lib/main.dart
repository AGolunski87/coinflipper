import 'package:flutter/material.dart';
import 'screens/coin_flipper_screen.dart';
import 'shared/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const CoinFlipperApp());
}

class CoinFlipperApp extends StatelessWidget {
  const CoinFlipperApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coin Flipper',
      theme: ThemeData(
        primaryColor: Constants.primaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const CoinFlipperScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
