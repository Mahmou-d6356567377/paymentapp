import 'package:flutter/material.dart';
import 'package:paymentapp/features/checkout/presentation/widgets/ThankYou_body.dart';

class ThankyouView extends StatelessWidget {
  const ThankyouView({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: ThankyouBody(),
    );
  }
}