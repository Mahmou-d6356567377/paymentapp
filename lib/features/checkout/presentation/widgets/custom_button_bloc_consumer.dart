import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paymentapp/core/utils/apikeys.dart';
import 'package:paymentapp/features/checkout/presentation/manager/payment/cubit/payment_cubit.dart';
import 'package:paymentapp/features/checkout/presentation/view/ThankYou_view.dart';
import 'package:paymentapp/features/checkout/presentation/widgets/custom_button.dart'
    show CustomButton;

import '../../data/models/payment_intent_input_model.dart';

class CustomButtonPaymentConsumer extends StatelessWidget {
  const CustomButtonPaymentConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is PaymentSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ThankyouView()),
          );
        } else if (state is PaymentFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      builder: (context, state) {
        return CustomButton(
          onpress: () {
            BlocProvider.of<PaymentCubit>(context).makePayment(
              paymentIntentInputModel: PaymentIntentInputModel(
                amount: 1000,
                currency: 'USD',
                customerId: Apikeys.customerId,
              ),
            );
          },
          title: 'Continue',
          isLoading: state is PaymentLoading ? true : false,
        );
      },
    );
  }
}
