import 'package:flutter/material.dart';
import '../shared/constants.dart';

class CoinDisplayWidget extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onFlip;

  const CoinDisplayWidget({
    Key? key,
    required this.imageUrl,
    required this.onFlip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.network(
          imageUrl,
          width: 150,
          height: 150,
          errorBuilder: (_, __, ___) =>
              const Icon(Icons.error, size: 150, color: Colors.red),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Constants.primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          onPressed: onFlip,
          child: const Text('Flip Coin', style: Constants.labelStyle),
        ),
      ],
    );
  }
}
