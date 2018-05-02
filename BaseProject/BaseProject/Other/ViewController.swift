//
//  ViewController.swift
//  BaseProject
//
//  Created by 玛丽 on 2018/4/25.
//  Copyright © 2018年 玛丽. All rights reserved.
//

import UIKit
import Foundation




extension Int {
    func hexedString() -> String {
        return NSString(format: "%02x", self) as String
    }
}

extension NSData {
    func hexedString() -> String {
        var string = String()
        let unsafePointer = bytes.assumingMemoryBound(to: UInt8.self)
        for i in UnsafeBufferPointer<UInt8>(start: unsafePointer, count: length) {
            string += Int(i).hexedString()
        }
        return string
    }
    func MD5() -> NSData {
        let result = NSMutableData(length: Int(CC_MD5_DIGEST_LENGTH))!
        let unsafePointer = result.mutableBytes.assumingMemoryBound(to: UInt8.self)
        CC_MD5(bytes, CC_LONG(length), UnsafeMutablePointer<UInt8>(unsafePointer))
        return NSData(data: result as Data)
    }
}

extension String {
    func MD5() -> String {
        let data = (self as NSString).data(using: String.Encoding.utf8.rawValue)! as NSData
        return data.MD5().hexedString()
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = MLRandomColor
//        let token = getNoewTime()
//        let
//        MLHttpTool.postLoginTest(parameters: ["username":"18668057723", "pass":"123456"]) { (response) in
//            print(response)
//        }
        
        MLLog("aaaaaa嗷嗷", color: UIColor.green)
        MLLog("aaaaaa嗷嗷")
        MLLog("aaaaaa嗷嗷")
        MLLog("aaaaaa嗷嗷")
        MLLog("aaaaaa嗷嗷")
        MLLog("aaaaaa嗷嗷")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getNoewTime() -> String {
        let date = NSDate()
        let numtime = date.timeIntervalSince1970
        return String(format: "%.2ld", numtime)
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
//        let vc = ViewController()
//        self.rt_navigationController.pushViewController(vc, animated: true)
//        showShareAction(urlStr: "https://www.baidu.com", title: "分享标题", description: "分享的内容", thumbnailImage: UIImage(named: ""))
//        QQLoginAction { (response) in
//        }
//        WeChatLoginAction { (response) in
//        }
//        let dic = ["orderNo" : "201804271536090156044196",
//                   "payType" : "alipay",
//                   "body" : "201804271536090156044196"]
//        MLHttpTool.postGetPayTest(parameters: dic) { (response) in
//            payAction(urlStr: response as! String, payType: .alipay) { (response2) in
//                print(response2)
//            }
//        }https://gitee.com/lizhong_zhang/Medicine_66.git
    }
}

