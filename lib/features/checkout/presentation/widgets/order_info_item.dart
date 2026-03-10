import 'package:flutter/material.dart';
import 'package:paymentapp/core/utils/fonts.dart';

class OrderInfoItem extends StatelessWidget {
  const OrderInfoItem({super.key, required this.title, required this.value});
  final String title, value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        children: [
          Text(title, style: Fonts.style18),
          Spacer(),
          Text(value, style: Fonts.style18),
        ],
      ),
    );
  }
}
