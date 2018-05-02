//
//  MLShareConfigs.swift
//  BaseProject
//
//  Created by 玛丽 on 2018/4/26.
//  Copyright © 2018年 玛丽. All rights reserved.
//

import UIKit
import MonkeyKing

//class MLShareConfigs: NSObject {
//
//    struct Weibo {
//        static let appID = "1772193724"
//        static let appKey = "453283216b8c885dad2cdb430c74f62a"
//        static let redirectURL = "http://www.limon.top"
//    }
//
//    struct WeChat {
//        static let appID = "wx4868b35061f87885"
//        static let appKey = "64020361b8ec4c99936c0e3999a9f249"
//        static let miniAppID = "gh_d43f693ca31f"
//    }
//
//    struct QQ {
//        static let appID = "1104881792"
//    }
//
//    struct Pocket {
//        static let appID = "48363-344532f670a052acff492a25"
//        static let redirectURL = "pocketapp48363:authorizationFinished" // pocketapp + $prefix + :authorizationFinished
//    }
//
//    struct Alipay {
//        static let appID = "2016012101112529"
//    }
//
//    struct Twitter {
//        static let appID = "bFSwxYoVEFn1G9VhooO3grNv1"
//        static let appKey = "YxBInrlvGoMPJjN9Xa4pBeCVILgz8qTXYlNdvJzzYlt9ingbZ2"
//        static let redirectURL = "https://github.com/fyl00/MonkeyKing"
//    }
//}




// MARK: - 配置支付、分享 Key
struct Configs {
    
    struct Weibo {
        static let appID = "1772193724"
        static let appKey = "453283216b8c885dad2cdb430c74f62a"
        static let redirectURL = "http://www.limon.top"
    }
    
    struct WeChat {
        static let appID = "wx4868b35061f87885"
        static let appKey = "64020361b8ec4c99936c0e3999a9f249"
        static let miniAppID = "gh_d43f693ca31f"
    }
    
    struct QQ {
        static let appID = "1104881792"
    }
    
    struct Alipay {
        static let appID = "2016012101112529"
    }
    
}



// MARK: - 使用系统分享
public func showSystemShare(urlStr: String?, title: String?, description: String?, thumbnailImage: UIImage?) {
    
    let url = URL.init(string: urlStr!)!
    let info = MonkeyKing.Info(title: title, description: description, thumbnail: thumbnailImage, media: .url(url))
    let sessionMessage = MonkeyKing.Message.weChat(.session(info: info))
    let weChatSessionActivity = AnyActivity(
        type: UIActivityType(rawValue: "com.nixWork.China.WeChat.Session"),
        title: NSLocalizedString("WeChat Session", comment: ""),
        image: UIImage(named: "wechat_session")!,
        message: sessionMessage,
        completionHandler: { success in
            MLCommon.showSuccesWithStatus("分享成功！")
            print("Session success: \(success)")
    }
    )
    let timelineMessage = MonkeyKing.Message.weChat(.timeline(info: info))
    let weChatTimelineActivity = AnyActivity(
        type: UIActivityType(rawValue: "com.nixWork.China.WeChat.Timeline"),
        title: NSLocalizedString("WeChat Timeline", comment: ""),
        image: UIImage(named: "wechat_timeline")!,
        message: timelineMessage,
        completionHandler: { success in
            MLCommon.showSuccesWithStatus("分享成功！")
            print("Timeline success: \(success)")
    }
    )
    let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: [weChatSessionActivity, weChatTimelineActivity])
    windowRootViewController?.present(activityViewController, animated: true, completion: nil)
}

// MARK: - 三方分享，需要配置各应用的key
public func showShareAction(urlStr: String?, title: String?, description: String?, thumbnailImage: UIImage?) {
    let url = URL.init(string: urlStr!)!
    let info = MonkeyKing.Info(title: title, description: description, thumbnail: thumbnailImage, media: .url(url))
    ///配置分享的按钮,注意需求没有的需要去掉
    let types: [KPShareType] = [.qq, .qzone, .wechat, .wechatTimeline, .wechatFavorite, .weibo]
    let share = MLShareView(types: types)
    share.shareInfo = info
    applicationKeyWindow?.addSubview(share)
//    UIApplication.shared.windows.last?.addSubview(share)
}

// MARK: - 支付宝、微信支付
public enum PayType {
    case alipay
    case weiChat
}

// MARK: - 注意在比包内分别做不同支付方式的回调
public func payAction(urlStr: String, payType: PayType, completionHandler: @escaping MonkeyKing.PayCompletionHandler) {
    
    var order: MonkeyKing.Order
    
    switch payType {
    case .alipay:
        order = MonkeyKing.Order.alipay(urlString: urlStr, scheme: nil)
    default:
        order = MonkeyKing.Order.weChat(urlString: urlStr)
    }
    
    MonkeyKing.deliver(order) { result in
        print("result: \(result)")
        completionHandler(result)
    }
}

// MARK: - QQ 登录
public func QQLoginAction(_ success: @escaping(_ result: Any) -> ()) {
    MonkeyKing.oauth(for: .qq, scope: "get_user_info") { (info, _, _) in
        guard
            let info = info,
            let token = info["access_token"] as? String,
            let openID = info["openid"] as? String else {
                return
        }
        
        let query = "get_user_info"
        let userInfoApi = "https://graph.qq.com/user/\(query)"
        let para = [
            "openid": openID,
            "access_token": token,
            "oauth_consumer_key": Configs.QQ.appID
        ]
        
        // login_callback
//        RxAlamofire.requestJSON(.get, userInfoApi, parameters: para)
//            .subscribe(onNext: { (_, userInfo) in
//                KPLog("userInfo \(String(describing: userInfo))")
//                success(JSON.init(userInfo))
//            }, onError: { (e) in
//                KPLog(e)
//            })
//            .disposed(by: bag)
        
    }
}

// MARK: - 微信登录
public func WeChatLoginAction(_ success: @escaping(_ result: Any) -> ()) {
    MonkeyKing.oauth(for: .weChat) { (oauthInfo, _, _) in
        guard
            let token = oauthInfo?["access_token"] as? String,
            let openID = oauthInfo?["openid"] as? String,
            let refreshToken = oauthInfo?["refresh_token"] as? String,
            let expiresIn = oauthInfo?["expires_in"] as? Int else {
                return
        }
        let userInfoAPI = "https://api.weixin.qq.com/sns/userinfo"
        let parameters = [
            "openid": openID,
            "access_token": token
        ]
        // fetch UserInfo by userInfoAPI
        
        // login_callback
//        RxAlamofire.requestJSON(.get, userInfoAPI, parameters: parameters)
//            .subscribe(onNext: { (_, userInfo) in
//                KPLog("userInfo \(String(describing: json))")
//                guard var userInfo = userInfo as? [String: Any] else {
//                    return
//                }
//
//                userInfo["access_token"] = token
//                userInfo["openid"] = openID
//                userInfo["refresh_token"] = refreshToken
//                userInfo["expires_in"] = expiresIn
//
//                success(JSON.init(userInfo))
//            }, onError: { (e) in
//                KPLog(e)
//            })
//            .disposed(by: bag)
    }
}

