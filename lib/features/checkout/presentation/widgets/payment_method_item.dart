import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PaymentMethodItem extends StatelessWidget {
  const PaymentMethodItem({super.key, this.isSelected = false, required this.img});
  final bool isSelected;
  final String img;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      duration: Duration(milliseconds: 600),
      width: 103,
      height: 62,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: isSelected ? Color(0xFF34A853) : Color.fromARGB(255, 187, 186, 186),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        shadows: [
          BoxShadow(
            color: Color(0xFF34A853),
            blurRadius: 4,
            offset: Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Center(child: SvgPicture.asset(img)),
    );
  }
}
