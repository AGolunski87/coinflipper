// A dashboard page that shows four stat cards in a GridView.
// Each card has a title, a chart placeholder, a "Last updated" subtitle,
// and a "View Details" button that pops up a modal with the same info.

import 'package:flutter/material.dart';
import '../shared/StatsDrawer.dart';

//// DashboardPage with the StatsDrawer
class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

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
    final now = TimeOfDay.now().format(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Coin Flipper Dashboard')),
      drawer: StatsDrawer(onSelect: (t, c) => _showDetails(context, t, c)),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 3 / 4,
        children: [
          // ... same _buildStatCard calls as before ...
        ],
      ),
    );
  }
}
