// summary: A CoinFlipperScreen that uses the provided FlipServices to read live counts and flip the coin via the FAB.
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/shared//constants.dart';
import '/services/flip_service.dart';

class CoinFlipperScreen extends StatefulWidget {
  const CoinFlipperScreen({super.key});

  @override
  State<CoinFlipperScreen> createState() => _CoinFlipperScreenState();
}

class _CoinFlipperScreenState extends State<CoinFlipperScreen> {
  // Local state for the current coin face image.
  String _currentUrl = Constants.coinHeadsUrl;

  // Convenience getter to grab your FlipService instance.
  FlipService get _flipService => context.read<FlipService>();

  // Called by the FAB: picks heads/tails, updates UI, then writes to Firestore.
  Future<void> _flipCoin() async {
    final isHeads = Random().nextBool();
    setState(() {
      _currentUrl = isHeads ? Constants.coinHeadsUrl : Constants.coinTailsUrl;
    });
    await _flipService.addFlip(isHeads);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Coin Flipper')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Show the current coin face.
            Expanded(
              child: Center(child: Image.network(_currentUrl)),
            ),

            const SizedBox(height: 24),

            // StreamBuilder listens to your service's flips stream.
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: context.watch<FlipService>().watchFlips(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

                final docs = snapshot.data!.docs;
                final headsCount =
                    docs.where((d) => d.data()['result'] == 'heads').length;
                final tailsCount =
                    docs.where((d) => d.data()['result'] == 'tails').length;
                final totalCount = docs.length;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCounterColumn('Heads', headsCount),
                    _buildCounterColumn('Tails', tailsCount),
                    _buildCounterColumn('Total', totalCount),
                  ],
                );
              },
            ),
          ],
        ),
      ),

      // Floating action button to flip the coin.
      floatingActionButton: FloatingActionButton(
        onPressed: _flipCoin,
        child: const Icon(Icons.casino),
      ),
    );
  }

  Widget _buildCounterColumn(String label, int value) => Column(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text('$value', style: const TextStyle(fontSize: 20)),
        ],
      );
}
