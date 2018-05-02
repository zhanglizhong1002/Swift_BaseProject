//
//  MLCountDownView.swift
//  zhongXiang_Swift
//
//  Created by 玛丽 on 2018/3/20.
//  Copyright © 2018年 玛丽. All rights reserved.
//

import UIKit

class MLCountDownView: UIView {

    private var sendButton: UIButton! //发送验证码按钮
    private var countdownTimer: Timer? //定时器
    private var completeClosure: (()->())? //点击倒计时的回调
    //倒计时事件
    var remainingSeconds: Int = 0 {
        willSet {
            sendButton.setTitle("\(newValue)秒", for: .normal)
            
            if newValue <= 0 {
                sendButton.setTitle("重新获取验证码", for: .normal)
                isCounting = false
            }
        }
    }
    //是否正在进行倒计时
    var isCounting = false {
        willSet {
            if newValue {
                countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
                //设置倒计时时间
                remainingSeconds = 60
                sendButton.isUserInteractionEnabled = false
//                sendButton.backgroundColor = UIColor.gray
            } else {
                countdownTimer?.invalidate()
                countdownTimer = nil
                sendButton.isUserInteractionEnabled = true
//                sendButton.backgroundColor = UIColor.red
            }
            
            sendButton.isEnabled = !newValue
        }
    }
    
    
    
    
    ///创建SendButton
    func CreateSendButtonWithAcceptEvent(complete:@escaping () -> Void) {
        sendButton = UIButton.init(frame: self.bounds)
        sendButton.setTitle("获取验证码", for: .normal)
        sendButton.addTarget(self, action: #selector(sendButtonClick(sender:)),  for: .touchUpInside)
        sendButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        sendButton.titleLabel?.adjustsFontSizeToFitWidth = true
        sendButton.setTitleColor(MLMainColor, for: .normal)
        sendButton.backgroundColor = UIColor.white
        sendButton.layer.masksToBounds = true
        sendButton.layer.cornerRadius = self.bounds.size.height/2
        sendButton.layer.borderColor = MLMainColor.cgColor
        sendButton.layer.borderWidth = 1
        self.addSubview(sendButton)
        
        
        
        //闭包回调
        completeClosure = complete
    }
    
    
}

//MARK: -- 事件处理 --

extension MLCountDownView {
    
    
    ///开启倒计时
    func openCountDown() {
        isCounting = true
        
    }
    
    ///button事件
    @objc func sendButtonClick(sender:UIButton?){
        sender?.isUserInteractionEnabled = false
        ///防止连续点击
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            sender?.isUserInteractionEnabled = true
        }
        
        //闭包回调
        if (completeClosure != nil) {
            completeClosure!()
        }
    }
    ///定时器事件
    @objc func updateTime(_ timer: Timer) {
        remainingSeconds -= 1
    }
    
    
    ///从父视图中移除  这个时候 移除定时器
    override func willRemoveSubview(_ subview: UIView) {
        super.willRemoveSubview(subview)
        if (countdownTimer != nil) {
            countdownTimer?.invalidate()
            countdownTimer = nil
        }
        
    }
}

