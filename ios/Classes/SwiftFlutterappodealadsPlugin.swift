import Flutter
import UIKit
import Appodeal

public class SwiftFlutterappodealadsPlugin: NSObject, FlutterPlugin {
    let mchannel: FlutterMethodChannel;
    var mViewController: UIViewController?;
    
    init(methodChannel: FlutterMethodChannel){
        self.mViewController = nil;
        self.mchannel = methodChannel;
    }
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutterappodealads", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterappodealadsPlugin(methodChannel: channel)
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if (self.mViewController == nil) {
        self.mViewController = (UIApplication.shared.keyWindow?.rootViewController)!;
    }
    var args: Dictionary<String,Any> = [:];
    if call.arguments != nil{
        args = (call.arguments as! NSDictionary) as! Dictionary<String,Any>
    }
    if(call.method == "initialize"){
        let appKey = args["appKey"] as! String;
        let types : [Int] = args["types"] as! [Int];
        let consent = args["consent"] as! Bool;
        var type = AppodealAdType();
        for type2 in types {
            type.insert(appodealAdType(innerType: type2));
        }
        Appodeal.initialize(withApiKey: appKey, types: type, hasConsent: consent);
        result(true);
    } else if(call.method == "showBannerBottom"){
        Appodeal.showAd(AppodealShowStyle.bannerBottom, rootViewController: self.mViewController!);
        result(true);
    } else if(call.method == "hideBanner"){
        Appodeal.hideBanner();
        result(true);
    } else if(call.method == "showInterstitial"){
        Appodeal.showAd(AppodealShowStyle.interstitial, rootViewController: self.mViewController!);
        result(true);
    } else if(call.method == "showRewardedVideo"){
        Appodeal.showAd(AppodealShowStyle.rewardedVideo, rootViewController: self.mViewController!);
        result(true);
    } else if(call.method == "isLoaded"){
        let type = args["type"] as! Int;
        let adType = appodealShowStyle(innerType: type);
        result(Appodeal.isReadyForShow(with: adType));
        Appodeal.showAd(AppodealShowStyle.rewardedVideo, rootViewController: self.mViewController!);
        result(true);
    } else {
        result(FlutterMethodNotImplemented);
    }
  }
    
    private func appodealAdType(innerType: Int) -> AppodealAdType{
        switch innerType {
        case 0:
            return AppodealAdType.interstitial;
        case 2:
            return AppodealAdType.banner;
        case 4:
            return AppodealAdType.rewardedVideo;
        default:
            return AppodealAdType.interstitial;
        }
    }
    
    private func appodealShowStyle(innerType: Int) -> AppodealShowStyle{
        switch innerType {
        case 0:
            return AppodealShowStyle.interstitial;
        case 2:
            return AppodealShowStyle.bannerBottom;
        case 4:
            return AppodealShowStyle.rewardedVideo;
        default:
            return AppodealShowStyle.interstitial;
        }
    }
    
    
}
