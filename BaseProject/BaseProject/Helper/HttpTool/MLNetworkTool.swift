//
//  MLNetworkTool.swift
//  HuiBao_Swift
//
//  Created by 玛丽 on 2017/10/17.
//  Copyright © 2017年 bubukj. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MLNetworkTool: NSObject {

    class func postRequestData(URLString: String, parameters: [String : Any]? = nil, finishedCallback: @escaping(_ result: Any) -> ()) {
        MLNetworkTool.requestData(method: .post, URLString: URLString, parameters: parameters, finishedCallback: finishedCallback)
    }
    class func getRequestData(URLString: String, parameters: [String : Any]? = nil, finishedCallback: @escaping(_ result: Any) -> ()) {
        MLNetworkTool.requestData(method: .get, URLString: URLString, parameters: parameters, finishedCallback: finishedCallback)
    }
    class func requestData(method: HTTPMethod, URLString: String, parameters: [String : Any]? = nil, finishedCallback: @escaping(_ result: Any) -> ()) {
        
        let url = SERVER_PATH+"/"+URLString
//        var headers: HTTPHeaders = [:]
//        if (MLCommon.getCookie() != "") {
//            headers = [
//            "Content-Type":"application/json",
//            "Cookie":MLCommon.getCookie()
//            ]
//        }
        
        Alamofire.request(url, method: method, parameters: parameters, headers: nil).responseJSON { (response) in
            
//            let headerFields = response.response?.allHeaderFields as! [String: String]
//            let cookie = headerFields["Set-Cookie"]
//            if method == .post && cookie != nil {
//                MLCommon.saveCookie(cookie!)
//            }
            
            //输出对应的请求日志
            MLLog("----------------------------------------------------------------\n")
            MLLog("请求路径：\(url)")
            MLLog("请求参数：\(String(describing: parameters))\n")
            MLLog("\(String(describing: response.response?.statusCode))")
            MLLog("\(String(describing: response.data))")
            MLLog("\n----------------------------------------------------------------\n")
            
            MLLog("\(JSON(response.result.value ?? "null"))")
            
            guard let result = response.result.value else {
                MLCommon.showErrorWithStatus("加载失败")
                MLLog(response.result.error!)
                return
            }
            finishedCallback(result)
        }
    }
}
