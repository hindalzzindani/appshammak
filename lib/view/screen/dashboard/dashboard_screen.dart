import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shammak_ecommerce/helper/network_info.dart';
import 'package:flutter_shammak_ecommerce/provider/splash_provider.dart';
import 'package:flutter_shammak_ecommerce/view/screen/chat/inbox_screen.dart';
import 'package:flutter_shammak_ecommerce/localization/language_constrants.dart';
import 'package:flutter_shammak_ecommerce/utill/images.dart';
import 'package:flutter_shammak_ecommerce/view/screen/home/home_screens.dart';
import 'package:flutter_shammak_ecommerce/view/screen/more/more_screen.dart';
import 'package:flutter_shammak_ecommerce/view/screen/notification/notification_screen.dart';
import 'package:flutter_shammak_ecommerce/view/screen/order/order_screen.dart';
import 'package:provider/provider.dart';

class DashBoardScreen extends StatefulWidget {
  final _selectedItemColor = Colors.white;
  final _unselectedItemColor = Colors.white30;
  final _selectedBgColor = Colors.indigo;
  final _unselectedBgColor = Colors.blue;
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  PageController _pageController = PageController();
  int _pageIndex = 0;
  List<Widget> _screens;
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  bool singleVendor = false;
  @override
  void initState() {
    super.initState();
    singleVendor = Provider.of<SplashProvider>(context, listen: false)
            .configModel
            .businessMode ==
        "single";

    _screens = [
      HomePage(),
      singleVendor
          ? OrderScreen(isBacButtonExist: false)
          : InboxScreen(isBackButtonExist: false),
      singleVendor
          ? NotificationScreen(isBacButtonExist: false)
          : OrderScreen(isBacButtonExist: false),
      singleVendor ? MoreScreen() : NotificationScreen(isBacButtonExist: false),
      singleVendor ? SizedBox() : MoreScreen(),
    ];

    NetworkInfo.checkConnectivity(context);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> icons = const [
      Icon(Icons.home_outlined),
      Icon(Icons.explore_outlined),
      Icon(Icons.camera_alt_outlined)
    ];
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _setPage(0);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor:
              _pageIndex == 0 ? Colors.white : Colors.grey[200],
          // backgroundColor: Colors.transparent,
          // selectedBackgroundColor: Colors.indigo,
          unselectedItemColor: Colors.black54,
          selectedItemColor: Colors.red,
          selectedLabelStyle: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,

            fontFamily: "Ubuntu",
          ),

          unselectedLabelStyle: TextStyle(
            color: Colors.red,
            fontFamily: "Ubuntu",
          ), selectedFontSize: 12,
          // selectedItemColor: Theme.of(context).primaryColorLight

          selectedIconTheme: IconThemeData(color: Colors.yellow),
          unselectedIconTheme: IconThemeData(color: Colors.red),
          // unselectedItemColor: Theme.of(context).textTheme.bodyText1.color,
          showUnselectedLabels: true,
          currentIndex: _pageIndex,
          type: BottomNavigationBarType.shifting,
          items: _getBottomWidget(singleVendor),
          onTap: (int index) {
            _setPage(index);
          },
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens[index];
          },
        ),
      ),
    );
  }

  BottomNavigationBarItem _barItem(String icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
        // padding: EdgeInsets.symmetric(vertical: 10.0,),
        child: Image.asset(
          icon,
          color: index == _pageIndex
              ? Theme.of(context).primaryColor
              : Theme.of(context).textTheme.bodyText1.color.withOpacity(0.7),
          height: 25,
          width: 25,
        ),
      ),
      label: label,
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }

  List<BottomNavigationBarItem> _getBottomWidget(bool isSingleVendor) {
    List<BottomNavigationBarItem> _list = [];

    if (!isSingleVendor) {
      _list.add(_barItem(Images.home_image, getTranslated('home', context), 1));
      _list.add(_barItem(Images.offers, getTranslated('offers', context), 0));
      _list.add(
          _barItem(Images.shopping_image, getTranslated('orders', context), 2));
      _list.add(_barItem(
          Images.notification, getTranslated('notification', context), 3));
      _list.add(_barItem(Images.more_image, getTranslated('more', context), 4));
    } else {
      _list.add(_barItem(Images.home_image, getTranslated('home', context), 0));
      _list.add(
          _barItem(Images.shopping_image, getTranslated('orders', context), 1));
      _list.add(_barItem(
          Images.notification, getTranslated('notification', context), 2));
      _list.add(_barItem(Images.more_image, getTranslated('more', context), 3));
    }

    return _list;
  }
}
