import 'package:flutter/material.dart';

class CustomCheckIcon extends StatelessWidget {
  const CustomCheckIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 40,
      backgroundColor: Color(0xffD9D9D9),
      child: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.green,
        child: Icon(Icons.done, color: Colors.white, size: 40),
      ),
    );
  }
}
