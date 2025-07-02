// summary: Pins a single FlipService at the root of the widget tree.
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'screens/coin_flipper_screen.dart';
import '/services/flip_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    Provider<FlipService>(
      create: (_) => FlipService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coin Flipper',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const coin_flipper_screen(),
    );
  }
}
