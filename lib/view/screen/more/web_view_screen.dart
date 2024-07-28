import 'dart:async';
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shammak_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_shammak_ecommerce/view/basewidget/custom_loader.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../utill/images.dart';

class WebViewScreen extends StatefulWidget {
  final String title;
  final String url;
  WebViewScreen({@required this.url, @required this.title});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print(' could not launch $command');
    }
  }

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  WebViewController controllerGlobal;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
  
    void customLaunch(command) async {
      if (await canLaunch(command)) {
        await launch(command);
      } else {
        print(' could not launch $command');
      }
    }

    openwhatsapp() async{
      var whatsapp ="+967 771978787";
      var whatsappURl_android = "whatsapp://send?phone="+whatsapp+"&text=hello";
      var whatappURL_ios ="https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
      if(Platform.isIOS){
        // for iOS phone only
        if( await canLaunch(whatappURL_ios)){
          await launch(whatappURL_ios, forceSafariVC: false);
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: new Text("whatsapp no installed")));

        }

      }else{
        // android , web
        if( await canLaunch(whatsappURl_android)){
          await launch(whatsappURl_android);
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: new Text("whatsapp no installed")));

        }


      }

    }

    var child;
    return WillPopScope(
      onWillPop: _exitApp,
      child: Scaffold(
        backgroundColor: Color(0xfff3f0f0),
        body: Column(
          children: [
            CustomAppBar(title: widget.title),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(
                            20), //You can use EdgeInsets like above
                        // margin: EdgeInsets.all(5),
                        child: Text(
                          "مجموعة سالم محمد شماخ التجارية",
                          style: TextStyle(
                            fontFamily: "Ubuntu",
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            style: new TextStyle(
                                fontFamily: "Ubuntu",
                                fontSize: 14,
                                color: Colors.red),
                            text: "يسعدنا تواصلكم عبر الوسائل التالية",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                var url = "http://awalnet.tech";
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              }),
                      ])),
                      TextButton(
                        onPressed: () {
                          customLaunch(
                              'https://www.facebook.com/shammakh.trading.co');
                        },
                        child: new Icon(Icons.facebook_outlined,color: Colors.red,),

                        // backgroundColor: Colors.yellow,
                      ),
                      //
                      // child: GestureDetector(
                      //   onTap: (){
                      //     openwhatsapp();
                      //   },
                      //   child: Container(
                      //     padding: EdgeInsets.all(40),
                      //     child: Text(" contact US"),
                      //   ),
                      // ),

                      TextButton(
                        onPressed: () {
                          customLaunch(
                              'mailto:Info@shammakh.com.com?subject=test%20subject&body=test%20body');
                        },
                        child: new Icon(Icons.email_sharp,color: Colors.red),
                      ),
                      TextButton(
                        onPressed: () {
                          openwhatsapp();
                        },
                        child: new Icon(Icons.whatsapp,color: Colors.red),
                      ),
                      TextButton(
                        onPressed: () {
                          customLaunch('sms:+967 771978787');
                        },
                        child: new Icon(Icons.phone_android_sharp,color: Colors.red),
                        // color: Colors.red,
                        // backgroundColor: Colors.yellow,
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            style: new TextStyle(
                                fontFamily: "Ubuntu",
                                fontSize: 14,
                                color: Colors.red),
                            // text:
                            //     "تم تطوير التطبيق عن طريق شركة : AwalNet Technology ",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                var url = "http://awalnet.tech";
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              }),
                      ])),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: GestureDetector(
                            child: Image.asset(
                              Images
                                  .awal_image, // On click should redirect to an URL
                              width: 150.0,
                              height: 80.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _exitApp() async {
    if (controllerGlobal != null) {
      if (await controllerGlobal.canGoBack()) {
        controllerGlobal.goBack();
        return Future.value(false);
      } else {
        return Future.value(true);
      }
    } else {
      return Future.value(true);
    }
  }
}
