//
//  MLRealmManage.swift
//  zhongXiang_Swift
//
//  Created by 玛丽 on 2018/4/2.
//  Copyright © 2018年 玛丽. All rights reserved.
//

import UIKit
import RealmSwift

class MLRealmManage: NSObject {

    /*
    
    /// 查找个人信息表
    ///
    /// - Returns: MLUserInfoRealm
    class func ml_getUserInfo() -> MLUserInfoRealm {
        let realm = try! Realm()
        let localModel = realm.object(ofType: MLUserInfoRealm.self, forPrimaryKey: MLCommon.getUserMobie())
        return localModel!
    }
    
    
    /// 更新个人信息表
    ///
    /// - Parameter model: MLUserInfoModel
    class func ml_saveUserInfo(_ model: MLUserInfoModel) {
        let userInfo = MLUserInfoRealm()
        userInfo.parentId = (model.parentId)
        userInfo.joyScore = (model.joyScore)
        userInfo.loveHeart = (model.loveHeart)
        userInfo.mobile = (model.mobile)!
        userInfo.qrCode = (model.qrCode)!
        userInfo.inviteCode = (model.inviteCode)!
        userInfo.imageUrl = (model.imageUrl)!
        userInfo.username = (model.username)!
        userInfo.nickName = (model.nickName)!
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(userInfo, update: true)
        }
    }
    
    */
}
