// Reusable StatsDrawer widget and integration into both DashboardPage and CoinPage

import 'package:flutter/material.dart';

/// A reusable drawer listing all statistic modals.
class StatsDrawer extends StatelessWidget {
  final void Function(String title, Widget content) onSelect;

  const StatsDrawer({Key? key, required this.onSelect}) : super(key: key);

  Widget _buildPieChart() => Container(
        height: 120,
        color: Colors.blue.shade100,
        child: const Center(child: Text('Pie: H/T')),
      );
  Widget _buildConvergenceChart() => Container(
        height: 120,
        color: Colors.green.shade100,
        child: const Center(child: Text('Line: % Convergence')),
      );
  Widget _buildVisitorsToday() => Container(
        height: 120,
        color: Colors.purple.shade100,
        child: const Center(child: Text('42 Visitors')),
      );
  Widget _buildBusiestDayChart() => Container(
        height: 120,
        color: Colors.orange.shade100,
        child: const Center(child: Text('Bar: Busiest Day')),
      );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: const Text('Statistics',
                style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            leading: const Icon(Icons.pie_chart),
            title: const Text('Heads/Tails Share'),
            onTap: () => onSelect('Heads/Tails Share', _buildPieChart()),
          ),
          ListTile(
            leading: const Icon(Icons.show_chart),
            title: const Text('Percentage Convergence'),
            onTap: () =>
                onSelect('Percentage Convergence', _buildConvergenceChart()),
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Visitors Today'),
            onTap: () => onSelect('Visitors Today', _buildVisitorsToday()),
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text('Busiest Day of Week'),
            onTap: () =>
                onSelect('Busiest Day of Week', _buildBusiestDayChart()),
          ),
        ],
      ),
    );
  }
}

/// DashboardPage with the StatsDrawer
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

/// CoinPage with the StatsDrawer
class CoinPage extends StatelessWidget {
  const CoinPage({Key? key}) : super(key: key);

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
