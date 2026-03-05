import 'package:flutter/material.dart';
import 'package:paymentapp/core/utils/fonts.dart';

class DoubleTextedRow extends StatelessWidget {
  const DoubleTextedRow({super.key, required this.title, required this.value , this.isbold = false});
  final String title, value;
  final bool isbold;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: isbold? Fonts.style25: Fonts.style16),
          Text(
            value,
            style:isbold? Fonts.style25: Fonts.style16.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
