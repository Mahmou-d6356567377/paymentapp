import 'package:flutter/material.dart';
import 'package:paymentapp/features/checkout/presentation/widgets/custom_app_bar.dart';
import 'package:paymentapp/features/checkout/presentation/widgets/payment_details_body.dart';

class PaymentDetailsView extends StatelessWidget {
  const PaymentDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Payment Details'),
      body: PaymentDetailsBody(),
      
    );
  }
}
