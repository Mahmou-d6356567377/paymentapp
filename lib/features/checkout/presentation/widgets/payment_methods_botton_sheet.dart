import 'package:flutter/material.dart';
import 'package:paymentapp/features/checkout/presentation/widgets/custom_button.dart';
import 'package:paymentapp/features/checkout/presentation/widgets/custom_button_bloc_consumer.dart';
import 'package:paymentapp/features/checkout/presentation/widgets/payment_methods_header.dart';

class PaymentMethodsBottonSheet extends StatelessWidget {
  const PaymentMethodsBottonSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 16),
          PaymentMethodsHeader(),
          SizedBox(height: 32),
          CustomButtonPaymentConsumer(),
        ],
      ),
    );
  }
}
