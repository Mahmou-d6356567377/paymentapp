
import 'package:flutter/material.dart';
import 'package:paymentapp/core/utils/colors.dart';
import 'package:paymentapp/core/utils/fonts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onpress, required this.title});

  final String title;
  final void Function()? onpress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: onpress,
          style: ElevatedButton.styleFrom(
            backgroundColor: ConstColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(title, style: Fonts.style22),
        ),
      ),
    );
  }
}
