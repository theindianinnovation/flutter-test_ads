// TODO: Import ad_helper.dart
import 'package:flutter/material.dart';
// TODO: Import google_mobile_ads.dart
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerInlinePage extends StatefulWidget {
  @override
  _BannerInlinePageState createState() => _BannerInlinePageState();
}

class _BannerInlinePageState extends State<BannerInlinePage> {

  // TODO: Add a BannerAd instance
  late BannerAd _ad;

  // TODO: Add _isAdLoaded
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    loadBannerAd();
    // TODO: Create a BannerAd instance

  }

  Future<void> loadBannerAd() async{
    _ad = BannerAd(

      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.banner,
      request: AdRequest(keywords: ['furniture','game','computer']),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();
          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );

    // TODO: Load an ad
    await _ad.load();
  }
  @override
  void dispose() {
    // TODO: Dispose a BannerAd object
    _ad.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isAdLoaded) {
      return Scaffold(
        body: Center(
          child: Container(
            child: AdWidget(ad: _ad),
            width: _ad.size.width.toDouble(),
            height: 72.0,
            alignment: Alignment.center,
          ),
        ),
      );
    } else return Container();
  }
}
