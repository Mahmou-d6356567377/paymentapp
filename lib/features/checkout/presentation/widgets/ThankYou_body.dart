import 'package:flutter/material.dart';
import 'package:paymentapp/features/checkout/presentation/widgets/custom_check_icon.dart';
import 'package:paymentapp/features/checkout/presentation/widgets/custom_dashed_line.dart';
import 'package:paymentapp/features/checkout/presentation/widgets/thank_u_card.dart';

class ThankyouBody extends StatelessWidget {
  const ThankyouBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(padding: const EdgeInsets.all(30.0), child: ThankYouCard()),
        Positioned(
          left: 20,
          right: 20,
          bottom: MediaQuery.sizeOf(context).height * 0.28,
          child: Row(
            children: [
              CircleAvatar(backgroundColor: Color(0xfffef7ff)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: CustomDashedLine(),
                ),
              ),
              CircleAvatar(backgroundColor: Color(0xfffef7ff)),
            ],
          ),
        ),

        Positioned(left: 0, right: 0, top: 18, child: CustomCheckIcon()),
        Positioned(
          left: 25,
          top: 18,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
      ],
    );
  }
}
