package com.linesandpixels.flutterappodealads;

import android.app.Activity;
import android.content.Context;

import androidx.annotation.NonNull;

import com.appodeal.ads.Appodeal;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FlutterappodealadsPlugin */
public class FlutterappodealadsPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private  MethodChannel methodChannel;
  private  Activity activity;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    methodChannel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutterappodealads");
    methodChannel.setMethodCallHandler(this);
  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  public static void registerWith(Registrar registrar) {
    //activity = registrar.activity();
    final FlutterappodealadsPlugin instance = new FlutterappodealadsPlugin();
    instance.onAttachedToEngine(registrar.context(), registrar.messenger());
    /*final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutterappodealads");
    channel.setMethodCallHandler(new FlutterappodealadsPlugin());*/
  }

  private void onAttachedToEngine(Context applicationContext, BinaryMessenger messenger) {
    methodChannel = new MethodChannel(messenger, "flutterappodealads");
    methodChannel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {

    if (activity == null) {
      result.error("no_activity", "flutterappodealads requires a foreground activity", null);
      return;
    }
    if (call.method.equals("initialize")) {
      String appKey = call.argument("appKey");
      List<Integer> types = call.argument("types");
      Boolean consent = call.argument("consent");
      int type = Appodeal.NONE;
      for (int type2 : types) {
        type = type | this.appodealAdType(type2);
      }
      Appodeal.initialize(activity, appKey, type, consent);
      result.success(Boolean.TRUE);
    } else if (call.method.equals("showBannerBottom")) {
      Appodeal.show(activity, Appodeal.BANNER_BOTTOM);
      result.success(Boolean.TRUE);
    } else if (call.method.equals("hideBanner")) {
      Appodeal.hide(activity, Appodeal.BANNER);
      result.success(Boolean.TRUE);
    } else if (call.method.equals("showInterstitial")) {
      Appodeal.show(activity, Appodeal.INTERSTITIAL);
      result.success(Boolean.TRUE);
    } else if (call.method.equals("showRewardedVideo")) {
      Appodeal.show(activity, Appodeal.REWARDED_VIDEO);
      result.success(Boolean.TRUE);
    } else if (call.method.equals("isLoaded")) {
      int type = call.argument("type");
      int adType = this.appodealAdType(type);
      result.success(Appodeal.isLoaded(adType));
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    methodChannel.setMethodCallHandler(null);
  }

  private int appodealAdType(int innerType) {
    switch (innerType) {
      case 0:
        return Appodeal.INTERSTITIAL;
      case 1:
        return Appodeal.NON_SKIPPABLE_VIDEO;
      case 2:
        return Appodeal.BANNER_BOTTOM;
      case 3:
        return Appodeal.NATIVE;
      case 4:
        return Appodeal.REWARDED_VIDEO;
      case 5:
        return Appodeal.MREC;
      case 6:
        return Appodeal.NON_SKIPPABLE_VIDEO;
    }
    return Appodeal.INTERSTITIAL;
  }

  @Override
  public void onAttachedToActivity(ActivityPluginBinding activityPluginBinding) {
    activity = activityPluginBinding.getActivity();
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    onDetachedFromActivity();
  }

  @Override
  public void onReattachedToActivityForConfigChanges(ActivityPluginBinding activityPluginBinding) {
    onAttachedToActivity(activityPluginBinding);
  }

  @Override
  public void onDetachedFromActivity() {
    activity = null;
  }

  private Map<String, Object> argumentsMap(Object... args) {
    Map<String, Object> arguments = new HashMap<>();
    for (int i = 0; i < args.length; i += 2) arguments.put(args[i].toString(), args[i + 1]);
    return arguments;
  }

  /*// Appodeal Rewarded Video Callbacks
  @Override
  public void onRewardedVideoLoaded(boolean isPrecache) {
    methodChannel.invokeMethod("onRewardedVideoLoaded", argumentsMap());
  }

  @Override
  public void onRewardedVideoFailedToLoad() {
    methodChannel.invokeMethod("onRewardedVideoFailedToLoad", argumentsMap());
  }

  @Override
  public void onRewardedVideoShown() {
    methodChannel.invokeMethod("onRewardedVideoPresent", argumentsMap());
  }

  @Override
  public void onRewardedVideoShowFailed() {
    methodChannel.invokeMethod("onRewardedVideoShowFailed", argumentsMap());
  }

  @Override
  public void onRewardedVideoClicked() {
    methodChannel.invokeMethod("onRewardedVideoClicked", argumentsMap());
  }

  @Override
  public void onRewardedVideoFinished(double amount, String name) {
    methodChannel.invokeMethod("onRewardedVideoFinished", argumentsMap());
  }

  @Override
  public void onRewardedVideoClosed(boolean finished) {
    methodChannel.invokeMethod("onRewardedVideoWillDismiss", argumentsMap());
  }

  @Override
  public void onRewardedVideoExpired() {
    methodChannel.invokeMethod("onRewardedVideoExpired", argumentsMap());
  }*/

}
