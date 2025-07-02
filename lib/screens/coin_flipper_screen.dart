import 'dart:math';
import 'package:flutter/material.dart';
import '../shared/constants.dart';
import '../widgets/coin_display_widget.dart';

class CoinFlipperScreen extends StatefulWidget {
  const CoinFlipperScreen({Key? key}) : super(key: key);

  @override
  _CoinFlipperScreenState createState() => _CoinFlipperScreenState();
}

class _CoinFlipperScreenState extends State<CoinFlipperScreen> {
  String _currentUrl = Constants.coinHeadsUrl;
  int _totalFlips = 0;
  int _headsCount = 0;
  int _tailsCount = 0;

  void _flipCoin() {
    final isHeads = Random().nextBool();
    setState(() {
      _currentUrl = isHeads ? Constants.coinHeadsUrl : Constants.coinTailsUrl;
      _totalFlips++;
      if (isHeads)
        _headsCount++;
      else
        _tailsCount++;
    });
    // TODO: write this flip to Firestore
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: Constants.screenPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Coin Flipper', style: Constants.titleStyle),
            const SizedBox(height: 32),
            CoinDisplayWidget(imageUrl: _currentUrl, onFlip: _flipCoin),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStat('Total', _totalFlips),
                _buildStat('Heads', _headsCount),
                _buildStat('Tails', _tailsCount),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, int value) {
    return Column(
      children: [
        Text(value.toString(), style: Constants.titleStyle),
        const SizedBox(height: 4),
        Text(label, style: Constants.labelStyle),
      ],
    );
  }
}
