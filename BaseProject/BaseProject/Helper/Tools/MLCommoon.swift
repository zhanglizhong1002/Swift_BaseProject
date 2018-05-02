//
//  MLCommoon.swift
//  HuiBao_Swift
//
//  Created by 玛丽 on 2017/10/17.
//  Copyright © 2017年 bubukj. All rights reserved.
//

import Foundation
import SnapKit
import IQKeyboardManagerSwift
import SVProgressHUD

//public let SERVER_PATH = ""
public let SERVER_PATH = "http://www.zhuozhuomu.com"



/// 搜索保存路径
let ML_CommoditySearchPath:String = NSHomeDirectory() + "/Documents/ml_searchCommodity.plist"
let ML_BusinessSearchPath:String  = NSHomeDirectory() + "/Documents/ml_searchBusiness.plist"


let ML_UserMobie:String = "mobie"
let ML_IsLogin:String   = "islogin"
let ML_Cookie:String    = "setcookie"



/// Key+Secret
let kAMapAppId:String       = "5dabffd54c28d5971c1aa5e169e7330e"
let kWeiboAppKey:String     = "1304172550"
let kWeiboAppSecret:String  = "5dabffd54c28d5971c1aa5e169e7330e"
let kWechatAppKey:String    = "wx655af1580934fec5"
let kWechatAppSecret:String = "6ac5923ec1d3894380733c2710dd5a43"
let kQQAppId:String         = "1106494406"



public let kScreenWidth: CGFloat  = UIScreen.main.bounds.size.width
public let kScreenHeight: CGFloat = UIScreen.main.bounds.size.height
public let KScreenBounds: CGRect  = UIScreen.main.bounds
//适配iPhoneX
let isIPhoneX = (kScreenWidth == 375.0 && kScreenHeight == 812.0 ? true : false)
let kNavibarH: CGFloat = isIPhoneX ? 88.0 : 64.0
let kTabbarH: CGFloat = isIPhoneX ? 49.0 + 34.0 : 49.0
let kStatusbarH: CGFloat = isIPhoneX ? 44.0 : 20.0
let iPhoneXBottomH: CGFloat = isIPhoneX ? 34.0 : 0
let iPhoneXTopH: CGFloat = isIPhoneX ? 24.0 : 0


public let MLMainColor = UIColor.colorWithHexString(hex: "#FF0101")
public let MLLineColor = UIColor.colorWithHexString(hex: "#E1E2E3")
public let MLTextColor = UIColor.colorWithHexString(hex: "#333333")
public let MLDarkColor = UIColor.colorWithHexString(hex: "#999999")
public let MLBackColor = UIColor.colorWithHexString(hex: "#F4F4F4")
public let MLRandomColor = UIColor(red: CGFloat(arc4random()%256)/255.0, green: CGFloat(arc4random()%256)/255.0, blue: CGFloat(arc4random()%256)/255.0, alpha: 1.0)

var windowRootViewController: UIViewController? {
    ///为避免在创建rootViewController之前调用了这个懒加载全局变量，所以写成get获取方式
    get {
        return (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController
    }
}
let applicationKeyWindow = UIApplication.shared.keyWindow
let shareApplication = UIApplication.shared
let delegate = shareApplication.delegate as? AppDelegate



class MLCommon: NSObject {
    
    class func showErrorWithStatus(_ status: String) {
        SVProgressHUD.showError(withStatus: status)
    }
    
    class func showWithStatus(_ status: String) {
        SVProgressHUD.show(withStatus: status)
    }
    
    class func showSuccesWithStatus(_ status: String) {
        SVProgressHUD.showSuccess(withStatus: status)
    }
    
    class func showInfoWithStatus(_ status: String) {
        SVProgressHUD.showInfo(withStatus: status)
    }
    
    class func dismissHUD() {
        SVProgressHUD.dismiss()
    }
    
    
    
    
    
    
    
    
    
    class func saveCookie(_ cookie: String) {
        UserDefaults.standard.set(cookie, forKey: ML_Cookie)
        UserDefaults.standard.synchronize()
    }
    
    class func getCookie() -> String {
        return UserDefaults.standard.string(forKey: ML_Cookie) ?? ""
    }
    
    
    class func saveIslogin(_ login: Bool) {
        UserDefaults.standard.set(login, forKey: ML_IsLogin)
        UserDefaults.standard.synchronize()
    }
    
    class func getIslogin() -> Bool {
        return UserDefaults.standard.bool(forKey: ML_IsLogin)
    }
    
    
    class func saveUserMobie(_ name: String) {
        UserDefaults.standard.set(name, forKey: ML_UserMobie)
        UserDefaults.standard.synchronize()
    }
    
    class func getUserMobie() -> String {
        return UserDefaults.standard.string(forKey: ML_UserMobie) ?? ""
    }
    
    //MARK: 搜索历史存储
    class func saveSearchArrayPlist(_ path: String, array: NSArray) {
        let filePath:String = path
        array.write(toFile: filePath, atomically: true)
    }
    
    //MARK: 搜索历史读取
    class func getSearchArrayPlist(_ path: String) -> NSArray {
        return (NSArray(contentsOfFile:path) ?? [])!
    }
}
