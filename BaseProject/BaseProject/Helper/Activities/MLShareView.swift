//
//  MLShareView.swift
//  BaseProject
//
//  Created by 玛丽 on 2018/4/27.
//  Copyright © 2018年 玛丽. All rights reserved.
//

import UIKit
import MonkeyKing

public enum KPShareType {
    case qq
    case qzone /// QQ 空间
    case wechat /// 微信好友
    case wechatTimeline /// 微信朋友圈
    case wechatFavorite /// 微信收藏
    case weibo /// 微博
}

class MLShareView: UIView {
    
    var cancelButton: UIButton!
    var shareInfo: MonkeyKing.Info?
    var accessToken: String?
    
    fileprivate var types: [KPShareType]!
    
    
    init(types: [KPShareType]) {
        super.init(frame: UIScreen.main.bounds)
        self.types = [.qq, .qzone, .wechat, .wechatTimeline, .wechatFavorite]
        prepareView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 创建视图
    fileprivate func prepareView() {
        
        _ = UIButton().then {
            $0.backgroundColor = .black
            $0.alpha = 0.4
            $0.addTarget(self, action: #selector(cancelAction(sender:)), for: .touchUpInside)
            self.addSubview($0)
            $0.snp.makeConstraints({ (make) in
                make.edges.equalTo(self)
            })
        }
        
        let boxView = UIView().then {
            $0.backgroundColor = .white
            self.addSubview($0)
            $0.snp.makeConstraints({ (make) in
                make.left.bottom.right.equalTo(self)
                make.height.equalTo(40+45+100+iPhoneXBottomH)
            })
        }
        
        _ = UILabel().then {
            $0.text = "请选择分享平台"
            $0.textColor = .darkText
            $0.textAlignment = .center
            $0.font = UIFont.systemFont(ofSize: 17)
            boxView.addSubview($0)
            $0.snp.makeConstraints({ (make) in
                make.top.left.right.equalTo(boxView)
                make.height.equalTo(40)
            })
        }
        
        let cancelBtn = UIButton().then {
            $0.setTitle("取消", for: .normal)
            $0.setTitleColor(.darkText, for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            $0.addTarget(self, action: #selector(cancelAction(sender:)), for: .touchUpInside)
            boxView.addSubview($0)
            $0.snp.makeConstraints({ (make) in
                make.left.right.equalTo(boxView)
                make.bottom.equalTo(iPhoneXBottomH)
                make.height.equalTo(44)
            })
        }
        
        _ = UIView().then {
            $0.backgroundColor = MLLineColor
            boxView.addSubview($0)
            $0.snp.makeConstraints({ (make) in
                make.left.right.equalTo(boxView)
                make.top.equalTo(40)
                make.height.equalTo(0.5)
            })
        }
        
        _ = UIView().then {
            $0.backgroundColor = MLLineColor
            boxView.addSubview($0)
            $0.snp.makeConstraints({ (make) in
                make.left.right.equalTo(boxView)
                make.bottom.equalTo(cancelBtn.snp.top).offset(-1)
                make.height.equalTo(0.5)
            })
        }
        
        for (index, item) in types.enumerated() {
            var title = ""
            var image: UIImage?
            switch item {
            case .qq:
                title = "QQ"
                image = UIImage.init(named: "umsocial_qq")
            case .wechat:
                title = "微信"
                image = UIImage.init(named: "umsocial_wechat")
            case .wechatTimeline:
                title = "微信朋友圈"
                image = UIImage.init(named: "umsocial_wechat_timeline")
            case .wechatFavorite:
                title = "微信收藏"
                image = UIImage.init(named: "umsocial_wechat_favorite")
            case .qzone:
                title = "QQ空间"
                image = UIImage.init(named: "umsocial_qzone")
            case .weibo:
                title = "新浪微博"
                image = UIImage.init(named: "umsocial_sina")
            }
            
            let itemW = kScreenWidth/CGFloat(types.count)
            let itemView = UIButton().then {
                $0.frame = CGRect(x: itemW*CGFloat(index), y: 40, width: itemW, height: 80)
                $0.tag = 100 + index
                $0.addTarget(self, action: #selector(shareAction(sender:)), for: .touchUpInside)
                boxView.addSubview($0)
            }
            
            let img = UIImageView().then {
                $0.image = image
                itemView.addSubview($0)
                $0.snp.makeConstraints({ (make) in
                    make.top.equalTo(8)
                    make.centerX.equalTo(itemView)
                    make.size.equalTo(CGSize(width: 50, height: 50))
                })
            }
            _ = UILabel().then {
                $0.text = title
                $0.textColor = UIColor.lightGray
                $0.font = UIFont.systemFont(ofSize: 13)
                itemView.addSubview($0)
                $0.snp.makeConstraints({ (make) in
                    make.top.equalTo(img.snp.bottom).offset(4)
                    make.centerX.equalTo(itemView)
                })
            }
        }
        
    }
    
    @objc
    fileprivate func shareAction(sender: UIButton) {
        
        guard let shareInfo = shareInfo else {
            MLCommon.showInfoWithStatus("请先配置分享数据！")
            return
        }
        let type = types[sender.tag-100]
        var message: MonkeyKing.Message?
        switch type {
        case .qq:
            MLLog("QQ 分享")
            message = .qq(.friends(info: shareInfo))
        case .wechat:
            MLLog("微信分享")
            message = .weChat(.session(info: shareInfo))
        case .wechatTimeline:
            MLLog("微信朋友圈分享")
            message = .weChat(.timeline(info: shareInfo))
        case .wechatFavorite:
            MLLog("微信收藏分享")
            message = .weChat(.favorite(info: shareInfo))
        case .qzone:
            MLLog("QQ 空间分享")
            message = .qq(.zone(info: shareInfo))
        case .weibo:
            MLLog("微博分享")
            if !MonkeyKing.SupportedPlatform.weibo.isAppInstalled {
                MonkeyKing.oauth(for: .weibo) { [weak self] (info, response, error) in
                    if let accessToken = info?["access_token"] as? String {
                        self?.accessToken = accessToken
                    }
                    print("MonkeyKing.oauth info: \(String(describing: info)),response:\(String(describing: response)), error: \(String(describing: error))")
                }
            }
            message = .weibo(.default(info: shareInfo, accessToken: accessToken))
        }
        
        guard let msg = message else {
            MLCommon.showErrorWithStatus("分享类型错误！")
            return
        }
        MonkeyKing.deliver(msg) { result in
            switch result {
            case .success(let json):
                MLLog(json)
                MLCommon.showSuccesWithStatus("分享成功")
            case .failure(let error):
                MLLog(error)
                switch error {
                case .messageCanNotBeDelivered:
                    MLCommon.showErrorWithStatus("没有安装客户端")
                default:
                    MLCommon.showErrorWithStatus("分享错误")
                    MLLog(error)
                    break
                }
            }
        }
        self.removeFromSuperview()
    }
    
    @objc
    fileprivate func cancelAction(sender: UIButton) {
        MLLog("取消")
        self.removeFromSuperview()
    }
    
}

