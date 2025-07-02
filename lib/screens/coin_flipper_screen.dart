// lib/screens/coin_page.dart
// A CoinPage that streams flip counts from Firestore and lets you flip a new coin.

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coin_flipper/shared/stats_drawer.dart';

class coin_flipper_screen extends StatefulWidget {
  const coin_flipper_screen({Key? key}) : super(key: key);

  @override
  State<coin_flipper_screen> createState() => _coin_flipper_screenState();
}

class _coin_flipper_screenState extends State<coin_flipper_screen> {
  final _flips = FirebaseFirestore.instance.collection('flips');

  Future<void> _flipCoin() async {
    final result = Random().nextBool() ? 'heads' : 'tails';
    await _flips.add({
      'result': result,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  void _showDetails(BuildContext context, String title, Widget content) {
    Navigator.pop(context); // close drawer
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
            Text(
              'Last updated: ${TimeOfDay.now().format(context)}',
              style: const TextStyle(color: Colors.grey),
            ),
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

      // 1️⃣ StreamBuilder to fetch heads/tails counts in real time
      body: StreamBuilder<QuerySnapshot>(
        stream: _flips.orderBy('timestamp').snapshots(),
        builder: (context, snap) {
          if (snap.hasError) return Center(child: Text('Error: ${snap.error}'));
          if (!snap.hasData)
            return const Center(child: CircularProgressIndicator());

          final docs = snap.data!.docs;
          final heads = docs.where((d) => d['result'] == 'heads').length;
          final tails = docs.where((d) => d['result'] == 'tails').length;
          final total = docs.length;

          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Heads: $heads',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text('Tails: $tails',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text('Total: $total',
                    style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
          );
        },
      ),

      // 2️⃣ FloatingActionButton to flip the coin
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _flipCoin,
        icon: const Icon(Icons.casino),
        label: const Text('Flip Coin'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
