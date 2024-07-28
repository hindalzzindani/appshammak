import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shammak_ecommerce/localization/language_constrants.dart';
import 'package:flutter_shammak_ecommerce/provider/auth_provider.dart';
import 'package:flutter_shammak_ecommerce/provider/brand_provider.dart';
import 'package:flutter_shammak_ecommerce/provider/category_provider.dart';
import 'package:flutter_shammak_ecommerce/provider/featured_deal_provider.dart';
import 'package:flutter_shammak_ecommerce/provider/home_category_product_provider.dart';
import 'package:flutter_shammak_ecommerce/provider/localization_provider.dart';
import 'package:flutter_shammak_ecommerce/provider/product_provider.dart';
import 'package:flutter_shammak_ecommerce/provider/profile_provider.dart';
import 'package:flutter_shammak_ecommerce/provider/splash_provider.dart';
import 'package:flutter_shammak_ecommerce/provider/top_seller_provider.dart';
import 'package:flutter_shammak_ecommerce/utill/app_constants.dart';
import 'package:flutter_shammak_ecommerce/utill/color_resources.dart';
import 'package:flutter_shammak_ecommerce/utill/custom_themes.dart';
import 'package:flutter_shammak_ecommerce/utill/dimensions.dart';
import 'package:flutter_shammak_ecommerce/view/basewidget/animated_custom_dialog.dart';
import 'package:provider/provider.dart';

import '../../auth/auth_screen.dart';
import '../../more/widget/sign_out_confirmation_dialog.dart';

class DeleteAccountDialog extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    Provider.of<ProfileProvider>(context, listen: false).userInfoModel.id;
    return Dialog(
      backgroundColor: Theme.of(context).highlightColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [

        Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          child: Text( getTranslated('delete_account', context),
              style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),),

        SizedBox(height: 100,
            child:Text(getTranslated('delete_account_txt', context), textAlign: TextAlign.left, style: TextStyle(color: Theme.of(context).textTheme.bodyText1.color),)
        ),

        Divider(height: Dimensions.PADDING_SIZE_EXTRA_SMALL, color: ColorResources.HINT_TEXT_COLOR),
        Row(children: [
          Expanded(child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(getTranslated('CANCEL', context), style: robotoRegular.copyWith(color: ColorResources.getYellow(context))),
          )),
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: VerticalDivider(width: Dimensions.PADDING_SIZE_EXTRA_SMALL, color: Theme.of(context).hintColor),
          ),
          Expanded(child: TextButton(
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).clearSharedData().then((condition) {
              Navigator.pop(context);
              Provider.of<ProfileProvider>(context,listen: false).clearHomeAddress();
              Provider.of<ProfileProvider>(context,listen: false).clearOfficeAddress();
              Provider.of<AuthProvider>(context,listen: false).clearSharedData();
              Provider.of<ProfileProvider>(context, listen: false).deleteAccountByID(Provider.of<ProfileProvider>(context, listen: false).userInfoModel.id.toString(), context);
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => AuthScreen()), (route) => false);

              });

            },
            child: Text(getTranslated('ok', context), style: robotoRegular.copyWith(color: ColorResources.getGreen(context))),
          )),
        ]),

      ]),
    );
  }
}
