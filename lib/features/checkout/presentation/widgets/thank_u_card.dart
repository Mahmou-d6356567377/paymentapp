import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paymentapp/core/utils/fonts.dart';
import 'package:paymentapp/core/utils/imgs_consts.dart';
import 'package:paymentapp/features/checkout/presentation/widgets/credit_card_list_tile.dart';
import 'package:paymentapp/features/checkout/presentation/widgets/double_texted_row.dart';

class ThankYouCard extends StatelessWidget {
  const ThankYouCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0, bottom: 18.0),
      decoration: ShapeDecoration(
        color: Color(0xffededed),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            SizedBox.fromSize(size: Size.fromHeight(40)),
            Text('Thank You!', style: Fonts.style22),
            Text('Your transaction was successful', style: Fonts.style16),

            SizedBox.fromSize(size: Size.fromHeight(40)),
            DoubleTextedRow(title: 'Date', value: '01/24/2023'),
            DoubleTextedRow(title: 'Time', value: '10:15 AM'),
            DoubleTextedRow(title: 'To', value: 'Sam Louis'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(thickness: 2),
            ),
            DoubleTextedRow(title: 'Total', value: '\$50.97', isbold: true),

            CreditCardListTile(),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(FontAwesomeIcons.barcode, size: 80),
                  Container(
                    width: 113,
                    height: 58,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 1.50,
                          color: Color(0xFF34A853),
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'PAID',
                        style: Fonts.style22.copyWith(color: Color(0xFF34A853)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
