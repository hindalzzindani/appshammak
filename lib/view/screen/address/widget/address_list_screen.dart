import 'package:flutter/material.dart';
import 'package:flutter_shammak_ecommerce/data/model/response/address_model.dart';
import 'package:flutter_shammak_ecommerce/utill/color_resources.dart';
import 'package:flutter_shammak_ecommerce/utill/custom_themes.dart';
import 'package:flutter_shammak_ecommerce/utill/images.dart';
class AddressListPage extends StatelessWidget {
  final AddressModel address;
  AddressListPage({Key key, this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        address.addressType == 'Home' ? Images.home_image
            : address.addressType == 'Workplace' ? Images.bag : Images.more_image,
        color: ColorResources.getSellerTxt(context), height: 30, width: 30,
      ),
      title: Text(address.address, style: titilliumRegular),
    );



  }
}
