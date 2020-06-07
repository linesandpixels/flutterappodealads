import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutterappodealads/flutterappodealads.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    try {
      List<AppodealAdType> types = new List<AppodealAdType>();
      types.add(AppodealAdType.AppodealAdTypeInterstitial);
      types.add(AppodealAdType.AppodealAdTypeRewardedVideo);
      /*Flutterappodealads.instance.videoListener =
          (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
        print("RewardedVideoAd event $event");
        setState(() {
          videoState = "State $event";
        });
      };*/
      // You should use here your APP Key from Appodeal
      await Flutterappodealads.instance
          .initialize(Platform.isIOS ? 'bfd1a95b29d4d5d0f1b9315f8ebd09fad1a4c8a8f745aa5e' : 'ANDROIDAPPKEY', types, false);
    } on PlatformException {}

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
      appBar: new AppBar(
        title: new Text('Flutter Appodeal Ads'),
      ),
      body: new Padding(
        padding: new EdgeInsets.only(top: 40.0),
        child: new Center(
            child: new Column(children: <Widget>[
          /*new Container(
              height: 100.0,
              color: Colors.green,
              child: new FlatButton(
                onPressed: () {
                  this.loadRewarded();
                },
                child: new Text('Show Rewarded'),
              )),*/
          new Container(
              height: 100.0,
              color: Colors.blue,
              child: new FlatButton(
                onPressed: () {
                  this.loadInterstital();
                },
                child: new Text('Show Interstitial'),
              ))
        ])),
      ),
    ));
  }

  void loadInterstital() async {
    bool loaded = await Flutterappodealads.instance
        .isLoaded(AppodealAdType.AppodealAdTypeInterstitial);
    if (loaded) {
      Flutterappodealads.instance.showInterstitial();
    } else {
      print("No se ha cargado un Interstitial");
    }
  }

  /*void loadRewarded() async {
    bool loaded = await Flutterappodealads.instance
        .isLoaded(AppodealAdType.AppodealAdTypeRewardedVideo);
    if (loaded) {
      Flutterappodealads.instance.showRewardedVideo();
    } else {
      print("No se ha cargado un Rewarded Video");
    }
  }*/
}
