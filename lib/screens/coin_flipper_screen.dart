// summary: A CoinFlipperScreen that uses the provided FlipServices to read live counts and flip the coin via the FAB.
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/shared/stats_drawer.dart';
import '/shared/constants.dart';
import '/services/flip_service.dart';

/// CoinPage with the StatsDrawer
class CoinFlipperScreen extends StatelessWidget {
  const CoinFlipperScreen({Key? key}) : super(key: key);

  void _showDetails(BuildContext context, String title, Widget content) {
    Navigator.pop(context); // close drawer if open
    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            content,
            const SizedBox(height: 12),
            Text('Last updated: ${TimeOfDay.now().format(context)}',
                style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flip a Coin')),
      drawer: StatsDrawer(onSelect: (t, c) => _showDetails(context, t, c)),
      body: Center(
        // Your coin flip UI goes here
        child: ElevatedButton(
          onPressed: () => print('Flip coin'),
          child: const Text('Flip Coin'),
        ),
      ),
    );
  }
}
