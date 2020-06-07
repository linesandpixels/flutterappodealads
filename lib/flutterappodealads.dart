import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

enum AppodealAdType {
  AppodealAdTypeInterstitial,
  AppodealAdTypeSkippableVideo,
  AppodealAdTypeBanner,
  AppodealAdTypeNativeAd,
  AppodealAdTypeRewardedVideo,
  AppodealAdTypeMREC,
  AppodealAdTypeNonSkippableVideo,
}

enum RewardedVideoAppodealAdEvent {
  loaded,
  failedToLoad,
  present,
  willDismiss,
  finish,
}

typedef void RewardedVideoAdListener(RewardedVideoAppodealAdEvent event,
    {String rewardType, double rewardAmount});

class Flutterappodealads {

  bool shouldCallListener;

  final MethodChannel _channel;

  /// Called when the status of the video ad changes.
  RewardedVideoAdListener videoListener;

  static const Map<String, RewardedVideoAppodealAdEvent> _methodToRewardedVideoAdEvent =
      const <String, RewardedVideoAppodealAdEvent>{
    'onRewardedVideoLoaded': RewardedVideoAppodealAdEvent.loaded,
    'onRewardedVideoFailedToLoad': RewardedVideoAppodealAdEvent.failedToLoad,
    'onRewardedVideoPresent': RewardedVideoAppodealAdEvent.present,
    'onRewardedVideoWillDismiss': RewardedVideoAppodealAdEvent.willDismiss,
    'onRewardedVideoFinished': RewardedVideoAppodealAdEvent.finish,
  };

  static final Flutterappodealads _instance = new Flutterappodealads.private(
    const MethodChannel('flutterappodealads'),
  );

  Flutterappodealads.private(MethodChannel channel) : _channel = channel {
    _channel.setMethodCallHandler(_handleMethod);
  }

  static Flutterappodealads get instance => _instance;

  Future initialize(
    String appKey,
    List<AppodealAdType> types,
    bool consent,
  ) async {
    shouldCallListener = false;
    List<int> itypes = new List<int>();
    for (final type in types) {
      itypes.add(type.index);
    }
    String consenttext = "no";
    if(consent){
      consenttext = "yes";
    }
    if(Platform.isIOS){
      _channel.invokeMethod('initialize', <String, dynamic>{
        'appKey': appKey,
        'types': itypes,
        //'consenttext': consenttext
        'consent': consent
      });
    } else {
      _channel.invokeMethod('initialize', <String, dynamic>{
        'appKey': appKey,
        'types': itypes,
        'consent': consent
        //'consent': consent
      });
    }
  }

  /*
    Shows an Interstitial in the root view controller or main activity
   */
  Future showInterstitial() async {
    shouldCallListener = false;
    _channel.invokeMethod('showInterstitial');
  }

  /*
    Shows an Interstitial in the root view controller or main activity
   */
  Future showBannerBottom() async {
    shouldCallListener = false;
    _channel.invokeMethod('showBannerBottom');
  }

  Future hideBanner() async {
    shouldCallListener = false;
    _channel.invokeMethod('hideBanner');
  }


  /*
    Shows an Rewarded Video in the root view controller or main activity
   */
  Future showRewardedVideo() async {
    shouldCallListener = true;
    _channel.invokeMethod('showRewardedVideo');
  }

  Future<bool> isLoaded(AppodealAdType type) async {
    shouldCallListener = false;
    final bool result = await _channel
        .invokeMethod('isLoaded', <String, dynamic>{'type': type.index});
    return result;
  }

  /*static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }*/

  Future<dynamic> _handleMethod(MethodCall call) {
    final Map<dynamic, dynamic> argumentsMap = call.arguments;
    final RewardedVideoAppodealAdEvent rewardedEvent =
        _methodToRewardedVideoAdEvent[call.method];
    if (rewardedEvent != null && shouldCallListener) {
      if (this.videoListener != null) {
        if (rewardedEvent == RewardedVideoAppodealAdEvent.finish && argumentsMap != null) {
          this.videoListener(rewardedEvent,
              rewardType: argumentsMap['rewardType'],
              rewardAmount: argumentsMap['rewardAmount']);
        } else {
          this.videoListener(rewardedEvent);
        }
      }
    }

    return new Future<Null>(null);
  }
}
