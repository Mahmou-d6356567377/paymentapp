import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:paymentapp/core/utils/apikeys.dart';
import 'package:paymentapp/features/checkout/data/models/transations_model/amount.dart';
import 'package:paymentapp/features/checkout/data/models/transations_model/details.dart';
import 'package:paymentapp/features/checkout/data/models/transations_model/item.dart';
import 'package:paymentapp/features/checkout/data/models/transations_model/item_list.dart';
import 'package:paymentapp/features/checkout/data/models/transations_model/transations_model.dart';
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

var amount = Amount(
  currency: "USD",
  total: "70.00", // ✅ REQUIRED
  details: Details(
    shipping: "0.00",
    subtotal: "70.00",
    shippingDiscount: "0.00",
  ),
);
            List<OrderItem> orders = [
              OrderItem(
                name: "Apple",
                quantity: 4,
                price: "5",
                currency: "USD",
              ),
              OrderItem(
                name: "Pineapple",
                quantity: 5,
                price: "10",
                currency: "USD",
              ),
            ];
            
            var itemlist = ItemList(orderitems: orders);

            Navigator.of(context).push(
              MaterialPageRoute(
                builder:
                    (BuildContext context) => PaypalCheckoutView(
                      sandboxMode: true,
                      clientId: Apikeys.paypalcustomerId,
                      secretKey: Apikeys.paypalsecretkey,
                      transactions: [
                        TransationsModel(
                          amount: amount,
                          itemList: itemlist,
                          description: "",
                        ).toJson(),
                      ],
                      note: "Contact us for any questions on your order.",
                      onSuccess: (Map params) async {
                        print("onSuccess: $params");
                      },
                      onError: (error) {
                        print("onError: $error");
                        Navigator.pop(context);
                      },
                      onCancel: () {
                        print('cancelled:');
                      },
                    ),
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
