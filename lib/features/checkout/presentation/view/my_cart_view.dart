import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paymentapp/core/utils/fonts.dart';
import 'package:paymentapp/core/utils/imgs_consts.dart';
import 'package:paymentapp/features/checkout/data/repos/checkout_repo_IMPL.dart';
import 'package:paymentapp/features/checkout/presentation/manager/payment/cubit/payment_cubit.dart';
import 'package:paymentapp/features/checkout/presentation/view/payment_details.dart';
import 'package:paymentapp/features/checkout/presentation/widgets/custom_app_bar.dart';
import 'package:paymentapp/features/checkout/presentation/widgets/custom_button.dart';
import 'package:paymentapp/features/checkout/presentation/widgets/order_info_item.dart';

import '../widgets/payment_methods_botton_sheet.dart'
    show PaymentMethodsBottonSheet;

class MyCartView extends StatelessWidget {
  const MyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'My Cart'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(ImgsConsts.basket),
              OrderInfoItem(title: 'Order Subtotal', value: '\$120.00'),
              OrderInfoItem(title: 'Discount', value: '-\$20.00'),
              OrderInfoItem(title: 'Shipping', value: '-\$20.00'),
              const Divider(),
              CustomButton(
                onpress: () {
                  showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder:
                        (context) => BlocProvider(
                          create: (context) => PaymentCubit(CheckoutRepoImpl()),
                          child: PaymentMethodsBottonSheet(),
                        ),
                  );

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const PaymentDetailsView(),
                  //   ),
                  // );
                },
                title: 'Complete Payment',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
