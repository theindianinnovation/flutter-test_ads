// TODO: Import ad_helper.dart
import 'package:flutter/material.dart';

// TODO: Import google_mobile_ads.dart
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdPage extends StatefulWidget {
  @override
  _InterstitialAdPageState createState() => _InterstitialAdPageState();
}

class _InterstitialAdPageState extends State<InterstitialAdPage> {
  // TODO: Add a BannerAd instance
  late InterstitialAd _ad;

  // TODO: Add _isAdLoaded
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    loadInterstitialAd();
    // TODO: Create a InterstitialAd instance

  }

  Future<void> loadInterstitialAd() async{
    await InterstitialAd.load(
      adUnitId: InterstitialAd.testAdUnitId,
      request: AdRequest(nonPersonalizedAds: true),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          this._ad = ad;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              Navigator.pop(context);
            },
          );

          _isAdLoaded = true;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
          _isAdLoaded = false;
        },
      ),
    );
  }
  @override
  void dispose() {
    // TODO: Dispose a BannerAd object
    _ad.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
       return Scaffold(
         body: Container(
           child:  Center(
             child: FlatButton(
               child: Text('Open Add'.toUpperCase()),
               onPressed: ()  {
                 // TODO: Display an Interstitial Ad
                  _ad.show();
               },
             ),
           ),
         ),
       );
  }
}
