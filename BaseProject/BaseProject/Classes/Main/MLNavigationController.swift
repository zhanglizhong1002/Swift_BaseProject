//
//  MLNavigationController.swift
//  HuiBao_Swift
//
//  Created by 玛丽 on 2017/10/17.
//  Copyright © 2017年 bubukj. All rights reserved.
//

import UIKit
import SVProgressHUD

class MLNavigationController: RTRootNavigationController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.isTranslucent = false
        let navBar = UINavigationBar.appearance()
        navBar.backgroundColor = .white
        navBar.setBackgroundImage(getNaviBackgroundImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.tintColor = UIColor.white
        navBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17)]
    }

    func getNaviBackgroundImage() -> UIImage {
        
        
        let gradientLayer = CAGradientLayer.init()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 88)
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [UIColor.colorWithHexString(hex: "FD6248").cgColor, UIColor.colorWithHexString(hex: "FF4338").cgColor]
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.viewControllers.count <= 1 {
            return false
        }
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "bt_back"), style: .plain, target: self, action: #selector(navigationBackClick))
        }
        super.pushViewController(viewController, animated: animated)
        self.setNavigationBarHidden(false, animated: true)
    }
    
    @objc func navigationBackClick() {
        if SVProgressHUD.isVisible() {
            MLCommon.dismissHUD()
        }
        if UIApplication.shared.isNetworkActivityIndicatorVisible {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        popViewController(animated: true)
    }

}
