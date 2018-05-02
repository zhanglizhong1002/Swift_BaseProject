//
//  MLHttpTool.swift
//  HuiBao_Swift
//
//  Created by 玛丽 on 2017/10/17.
//  Copyright © 2017年 bubukj. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class MLHttpTool: NSObject {

    /// test - pay
    class func postPayTest(parameters: [String : Any]? = nil, finishedCallback: @escaping(_ result: Any) -> ()) {
        MLCommon.showWithStatus("加载中")
        MLNetworkTool.postRequestData(URLString: "trade/alipay/app", parameters: parameters) { (response) in
            finishedCallback(response)
            MLCommon.dismissHUD()
        }
    }
    
    /// test - login
    class func postLoginTest(parameters: [String : Any]? = nil, finishedCallback: @escaping(_ result: Any) -> ()) {
        MLCommon.showWithStatus("加载中")
        MLNetworkTool.postRequestData(URLString: "login", parameters: parameters) { (response) in
            finishedCallback(response)
            MLCommon.dismissHUD()
        }
    }
    
    /// 登录
    class func postUserLogin(parameters: [String : Any]? = nil, finishedCallback: @escaping(_ result: Any) -> ()) {
        MLCommon.showWithStatus("登录中")
        MLNetworkTool.postRequestData(URLString: "member/login", parameters: parameters) { (response) in
            finishedCallback(response)
            MLCommon.showSuccesWithStatus("登录成功")
        }
    }
    
    
    /// 商家列表
    class func getMineStoreList(storeId: String, parameters: [String : Any]? = nil, finishedCallback: @escaping(_ result: Any) -> ()) {
        MLCommon.showWithStatus("加载中")
        MLNetworkTool.getRequestData(URLString: "admin/getStoreList/"+"\(storeId)", parameters: parameters) { (response) in
            finishedCallback(response)
            MLCommon.dismissHUD()
        }
    }
}
