import 'package:flutter/material.dart';
import 'package:flutter_ads_tutorial/inline_banner_page.dart';
import 'package:flutter_ads_tutorial/interstitial_ad_page.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: <String, WidgetBuilder>{
        '/banner': (context) =>
            BannerInlinePage(),
        '/native': (context) =>InterstitialAdPage(),
      },
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<InitializationStatus>(
            future: _initGoogleMobileAds(),
            builder: (context, snapshot) {
              List<Widget> children = [];
              if (snapshot.connectionState == ConnectionState.waiting) {
                children.add(Center(
                  child: SizedBox(
                    child: CircularProgressIndicator(),
                    width: 48.0,
                    height: 48.0,
                  ),
                ));
              } else {
                if (snapshot.hasData) {
                  children.addAll([
                    ElevatedButton(
                      child: Text('Banner inline ad'),
                      onPressed: () {
                        Navigator.pushNamed(context, '/banner');
                      },
                    ),
                    SizedBox(height: 8.0),
                    ElevatedButton(
                      child: Text('Native inline ad'),
                      onPressed: () {
                        Navigator.pushNamed(context, '/native');
                      },
                    ),
                  ]);
                } else if (snapshot.hasError) {
                  children.add(Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 24,
                        ),
                        SizedBox(width: 8.0),
                        Text('Failed to initialize AdMob SDK'),
                      ],
                    ),
                  ));
                }
              }

              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: children,
                ),
              );
            }),
      ),

  );

}}
