//
//  MLTabBarViewController.swift
//  HuiBao_Swift
//
//  Created by 玛丽 on 2017/10/17.
//  Copyright © 2017年 bubukj. All rights reserved.
//

import UIKit

class MLTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.tintColor = MLMainColor
        self.tabBar.isTranslucent = false
        addAllChildsControllors()
    }
}


extension MLTabBarViewController {
    ///添加所有的子控制器
    fileprivate func addAllChildsControllors() {
        
        addChildViewController(childVC: ViewController(), title: "首页", image: UIImage(named: "bt_tab_home"), selecteImage: UIImage(named: "bt_tab_home_sel"))
        addChildViewController(childVC: ViewController(), title: "购物车", image: UIImage(named: "bt_tab_shopping_cart"), selecteImage: UIImage(named: "bt_tab_shopping_cart_sel"))
        addChildViewController(childVC: ViewController(), title: "我的", image: UIImage(named: "bt_tab_mine"), selecteImage: UIImage(named: "bt_tab_mine_sel"))
    }
    
    ///添加一个控制器
    private func addChildViewController(childVC: UIViewController, title: String?, image: UIImage?, selecteImage: UIImage?) {
        childVC.title = title
        childVC.tabBarItem.setTitleTextAttributes({[NSAttributedStringKey.foregroundColor: UIColor.darkGray]}(), for: UIControlState.normal)
        childVC.tabBarItem.setTitleTextAttributes({[NSAttributedStringKey.foregroundColor: MLMainColor]}(), for: UIControlState.selected)
        childVC.tabBarItem.image = image
        childVC.tabBarItem.selectedImage = selecteImage
        let navC = MLNavigationController(rootViewController: childVC)
        addChildViewController(navC)
    }
}
