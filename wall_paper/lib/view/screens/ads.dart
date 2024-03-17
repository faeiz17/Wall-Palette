import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdWidget extends StatefulWidget {
  @override
  _BannerAdWidgetState createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  late BannerAd _bannerAd;

  @override
  void initState() {
    super.initState();

    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdFailedToLoad: (ad, error) {
          print('Ad failed to load: $error');
        },
        onAdLoaded: (ad) {
          print('Ad loaded successfully');
        },
      ),
    );

    _loadBannerAd();
  }

  void _loadBannerAd() {
    _bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Your screen content goes here

        // Banner ad
        Container(
          alignment: Alignment.bottomCenter,
          child: AdWidget(ad: _bannerAd),
          width: _bannerAd.size.width.toDouble(),
          height: _bannerAd.size.height.toDouble(),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }
}
