import 'package:flutter/material.dart';
import 'package:paymentapp/features/checkout/presentation/view/ThankYou_view.dart';
import 'package:paymentapp/features/checkout/presentation/view/credit_card_screen.dart';
import 'package:paymentapp/features/checkout/presentation/widgets/custom_button.dart';
import 'package:paymentapp/features/checkout/presentation/widgets/payment_methods_header.dart';

class PaymentDetailsBody extends StatefulWidget {
  const PaymentDetailsBody({super.key});

  @override
  State<PaymentDetailsBody> createState() => _PaymentDetailsBodyState();
}

class _PaymentDetailsBodyState extends State<PaymentDetailsBody> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: PaymentMethodsHeader()),
        SliverToBoxAdapter(
          child: CreditCardScreen(
            formKey: formKey,
            autovalidateMode: autovalidateMode,
          ),
        ),
        SliverToBoxAdapter(
          child: CustomButton(
            onpress: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ThankyouView()),
                );
                autovalidateMode = AutovalidateMode.always;
                setState(() {});
              }
            },
            title: 'Complete Payment',
          ),
        ),
      ],
    );
  }
}
