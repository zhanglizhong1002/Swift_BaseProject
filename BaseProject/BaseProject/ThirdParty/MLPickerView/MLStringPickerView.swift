//
//  MLStringPickerView.swift
//  zhongXiang_Swift
//
//  Created by 玛丽 on 2018/4/3.
//  Copyright © 2018年 玛丽. All rights reserved.
//

import UIKit

//创建协议
protocol MLStringPickerViewDelegate:NSObjectProtocol {
    func ml_selectValue(_ string: String)
}
class MLStringPickerView: MLBasePickerView {

    typealias selectCallBackBlock = (_ selectValue: String)->()
    var selectBlock : selectCallBackBlock?
    var delegate : MLStringPickerViewDelegate?
    
    lazy var pickerView: UIPickerView = {
        let node = UIPickerView(frame: CGRect(x: 0, y: kTopViewHeight+0.5, width: kScreenWidth, height: kPickerHeight))
        node.backgroundColor = .white
        node.showsSelectionIndicator = true
        node.delegate = self
        node.dataSource = self
        return node
    }()
    
    var dataArray: NSArray = []
    var selectValue: String = ""
    
    
    init(withArray: NSArray, title: String) {
        super.init(frame: .zero)
        
        // 需要处理array的类型
        
        self.titleLabel.text = title
        selectValue = withArray[0] as! String
        dataArray = withArray
        alertView.addSubview(pickerView)
    }
    
    // callback
    @objc override func clickSureButtonAction() {
        if self.selectBlock != nil {
            self.selectBlock!(selectValue)
        }
        if delegate != nil {
            delegate?.ml_selectValue(selectValue)
        }
        dismissViewAnimation(true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension  MLStringPickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.dataArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.dataArray[row] as? String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectValue = self.dataArray[row] as! String
//        self.titleLabel.text = selectValue
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        pickerView.subviews[1].backgroundColor = MLBackColor
        pickerView.subviews[2].backgroundColor = MLBackColor
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.alertView.frame.size.width, height: pickerView.subviews[2].frame.origin.y-pickerView.subviews[1].frame.origin.y))
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.text = self.dataArray[row] as? String
        return label
    }
}
