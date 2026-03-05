
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paymentapp/core/utils/fonts.dart';
import 'package:paymentapp/core/utils/imgs_consts.dart';

class CreditCardListTile extends StatelessWidget {
  const CreditCardListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      child: ListTile(
        leading: SvgPicture.asset(ImgsConsts.mastercard),
        title: Text('Credit Card', style: Fonts.style16,),
        subtitle: Text('Master Card****2456', style: Fonts.style14,),
      ),
    );
  }
}
