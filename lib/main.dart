import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:paymentapp/core/utils/apikeys.dart';
import 'package:paymentapp/features/checkout/presentation/view/my_cart_view.dart';

void main() {
  Stripe.publishableKey = Apikeys.publishableKey;
  runApp(const CheckoutApp());
}

class CheckoutApp extends StatelessWidget {
  const CheckoutApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyCartView(),
    );
  }
}

//create payment intent (amount, currency, )
//initPaymentSheet(SetupPaymentSheetParameters())

//present payment sheet()
