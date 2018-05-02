//
//  MLBasePickerView.swift
//  zhongXiang_Swift
//
//  Created by 玛丽 on 2018/4/4.
//  Copyright © 2018年 玛丽. All rights reserved.
//

import UIKit

public let kPickerHeight: CGFloat  = 216
public let kTopViewHeight: CGFloat  = 44
public let STATUSBAR_HEIGHT: CGFloat = UIApplication.shared.statusBarFrame.size.height // 状态栏的高度(20 / 44(iPhoneX))
public let IS_iPhoneX: Bool = (STATUSBAR_HEIGHT == 44) ? true : false
public let TOP_MARGIN: CGFloat = IS_iPhoneX ? 44 : 0 // 顶部安全区域远离高度
public let BOTTOM_MARGIN: CGFloat = IS_iPhoneX ? 34 : 0 // 底部安全区域远离高度




class MLBasePickerView: UIView {

    lazy var backgroundView: UIView = {
        let node = UIView()
        node.backgroundColor = .black
        node.alpha = 0.2
        node.isUserInteractionEnabled = true
        node.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backgroundViewTapAction(_:))))
        return node
    }()
    
    lazy var alertView: UIView = {
        let node = UIView()
        node.backgroundColor = .white
        return node
    }()
    
    lazy var topView: UIView = {
        let node = UIView()
        node.backgroundColor = .white
        return node
    }()
    
    lazy var cancelButton: UIButton = {
        let node = UIButton()
        node.setTitle("取消", for: .normal)
        node.setTitleColor(MLMainColor, for: .normal)
        node.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        node.addTarget(self, action: #selector(clickCancelButtonAction), for: .touchUpInside)
        return node
    }()
    
    lazy var sureButton: UIButton = {
        let node = UIButton()
        node.setTitle("确定", for: .normal)
        node.setTitleColor(MLMainColor, for: .normal)
        node.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        node.addTarget(self, action: #selector(clickSureButtonAction), for: .touchUpInside)
        return node
    }()
    
    lazy var titleLabel: UILabel = {
        let node = UILabel()
        node.textAlignment = .center
        node.textColor = MLDarkColor
        node.font = UIFont.systemFont(ofSize: 14)
        return node
    }()
    
    lazy var lineView: UIView = {
        let node = UIView()
        node.backgroundColor = MLLineColor
        return node
    }()
    
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.frame = UIScreen.main.bounds
        setLayout()
        showViewAnimation(true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        self.addSubview(backgroundView)
        self.addSubview(alertView)
        alertView.addSubview(topView)
        topView.addSubview(cancelButton)
        topView.addSubview(titleLabel)
        topView.addSubview(sureButton)
        topView.addSubview(lineView)
        // layout
        backgroundView.frame = self.frame
        alertView.frame = CGRect(x: 0, y: kScreenHeight-kPickerHeight-kTopViewHeight-BOTTOM_MARGIN, width: kScreenWidth, height: kPickerHeight+kTopViewHeight+BOTTOM_MARGIN)
        topView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kTopViewHeight)
        cancelButton.frame = CGRect(x: 5, y: 8, width: 60, height: 28)
        sureButton.frame = CGRect(x: kScreenWidth-65, y: 8, width: 60, height: 28)
        titleLabel.frame = CGRect(x: 65, y: 0, width: kScreenWidth-65*2, height: kTopViewHeight)
        lineView.frame = CGRect(x: 0, y: kTopViewHeight, width: kScreenWidth, height: 0.5)
    }
    
    // show
    func showViewAnimation(_ animation: Bool) {
        UIApplication.shared.keyWindow?.addSubview(self)
        if animation {
            var rect = alertView.frame
            rect.origin.y = kScreenHeight
            alertView.frame = rect
            UIView.animate(withDuration: 0.3) {
                var rect = self.alertView.frame
                rect.origin.y -= kPickerHeight + kTopViewHeight + BOTTOM_MARGIN
                self.alertView.frame = rect
            }
        }
    }
    
    // dismiss
    func dismissViewAnimation(_ animation: Bool) {
        UIView.animate(withDuration: 0.2, animations: {
            var rect = self.alertView.frame
            rect.origin.y += kPickerHeight+kTopViewHeight+BOTTOM_MARGIN
            self.alertView.frame = rect
            self.backgroundView.alpha = 0.0
        }) { (finished) in
            for view in self.subviews {
                view.removeFromSuperview()
            }
            self.removeFromSuperview()
        }
    }
    
    // cancel
    @objc func clickCancelButtonAction() {
        dismissViewAnimation(true)
    }
    
    // sure
    @objc func clickSureButtonAction() {
        
    }
    
    // dismiss
    @objc func backgroundViewTapAction(_ tap: UIGestureRecognizer) {
        dismissViewAnimation(true)
    }

}
