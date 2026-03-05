import 'package:flutter/material.dart';
import 'package:paymentapp/core/utils/imgs_consts.dart';
import 'package:paymentapp/features/checkout/presentation/widgets/payment_method_item.dart';

class PaymentMethodsHeader extends StatefulWidget {
  const PaymentMethodsHeader({super.key});

  @override
  State<PaymentMethodsHeader> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethodsHeader> {
  final List<String> paymentMethods = const [
    ImgsConsts.applepay,
    ImgsConsts.card,
    ImgsConsts.paypal,
  ];

  int activeindex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: paymentMethods.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                activeindex = index;
              });
            },
            child: PaymentMethodItem(
              img: paymentMethods[index],
              isSelected: index == activeindex,
            ),
          );
        },
      ),
    );
  }
}
