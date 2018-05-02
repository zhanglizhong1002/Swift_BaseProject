//
//  MLShareManager.swift
//  zhongXiang_Swift
//
//  Created by 玛丽 on 2018/4/8.
//  Copyright © 2018年 玛丽. All rights reserved.
//

import UIKit

class MLShareManager: NSObject {

    /*
    class func share(_ byText: String, url: URL) {
        // 1.创建分享参数
        let shareParames = NSMutableDictionary()
        shareParames.ssdkSetupShareParams(byText: byText,
                                          images : UIImage(named: "icon_about"),
                                          url : url,
                                          title : "众享汇",
                                          type : SSDKContentType.auto)
        
        ShareSDK.showShareActionSheet(nil, items: nil, shareParams: shareParames) { (state, platformType, userData, contentEntity, error, end) in
            
            switch state{
                
            case SSDKResponseState.success: print("分享成功")
            case SSDKResponseState.fail:    print("授权失败,错误描述:\(String(describing: error))")
            case SSDKResponseState.cancel:  print("操作取消")
                
            default:
                break
            }
        }
    }
     */
}
