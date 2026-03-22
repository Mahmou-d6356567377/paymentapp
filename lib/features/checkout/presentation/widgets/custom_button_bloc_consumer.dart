import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
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
            // BlocProvider.of<PaymentCubit>(context).makePayment(
            //   paymentIntentInputModel: PaymentIntentInputModel(
            //     amount: 1000,
            //     currency: 'USD',
            //     customerId: Apikeys.customerId,
            //   ),
            // ),
            // 
            // ;





            Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => PaypalCheckoutView(
                    sandboxMode: true,
                    clientId: "",
                    secretKey: "",
                    transactions: const [
                      {
                        "amount": {
                          "total": "70",
                          "currency": "USD",
                          "details": {
                            "subtotal": "70",
                            "shipping": "0",
                            "shipping_discount": 0
                          }
                        },
                        "description": "The payment transaction description.",
                        // "payment_options": {
                        //   "allowed_payment_method":
                        //       "INSTANT_FUNDING_SOURCE"
                        // },
                        "item_list": {
                          "items": [
                            {
                              "name": "Apple",
                              "quantity": 4,
                              "price": "5",
                              "currency": "USD"
                            },
                            {
                              "name": "Pineapple",
                              "quantity": 5,
                              "price": "10",
                              "currency": "USD"
                            }
                          ],

                          // shipping address is not required though
                          //   "shipping_address": {
                          //     "recipient_name": "tharwat",
                          //     "line1": "Alexandria",
                          //     "line2": "",
                          //     "city": "Alexandria",
                          //     "country_code": "EG",
                          //     "postal_code": "21505",
                          //     "phone": "+00000000",
                          //     "state": "Alexandria"
                          //  },
                        }
                      }
                    ],
                    note: "Contact us for any questions on your order.",
                    onSuccess: (Map params) async {
                      log("onSuccess: $params");
                    },
                    onError: (error) {
                      log("onError: $error");
                      Navigator.pop(context);
                    },
                    onCancel: () {
                      log('cancelled:');
                    },
                  ),
                ));
          },
          title: 'Continue',
          isLoading: state is PaymentLoading ? true : false,
        );
      },
    );
  }
}
