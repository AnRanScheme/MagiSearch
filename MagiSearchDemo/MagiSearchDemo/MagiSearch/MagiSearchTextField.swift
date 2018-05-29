//
//  MagiSearchTextField.swift
//  MagiSearchDemo
//
//  Created by 安然 on 2018/5/28.
//  Copyright © 2018年 MacBook. All rights reserved.
//

import UIKit

class MagiSearchTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        stupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func stupUI() {
        self.leftViewMode = .always
        let searchImageViewWrapper = UIView(frame: CGRect(x: 0,
                                                          y: 0,
                                                          width: 20,
                                                          height: 15))
        let searchImageView = UIImageView(frame: CGRect(x: 0,
                                                        y: 0,
                                                        width: 15,
                                                        height: 15))
        let search = UIImage(named: "search",
                             in: Bundle(for: MagiSearch.self),
                             compatibleWith: nil)
        searchImageView.image = search
        searchImageViewWrapper.addSubview(searchImageView)
        
        self.leftView = searchImageViewWrapper
        self.returnKeyType = .search
        self.placeholder = "搜索"
        self.font = UIFont.systemFont(ofSize: 14)
    }
}

class MagiSearchTextFieldView: UIView {
    
    var magiSearchTextField: MagiSearchTextField!
    
    var cancelButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupUI() {
        magiSearchTextField = MagiSearchTextField(frame: CGRect(x: 0,
                                                                y: 0,
                                                                width:  magi_width - 50,
                                                                height:frame.height))
        addSubview(magiSearchTextField)
        
        cancelButton = UIButton(frame: CGRect(x:  magi_width - 40,
                                              y: 0,
                                              width: 50,
                                              height: frame.height))
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        cancelButton.setTitleColor(UIColor.darkGray,
                                   for: .normal)
        cancelButton.setTitleColor(UIColor.darkGray.withAlphaComponent(0.3),
                                   for: .highlighted)
        cancelButton.setTitle("取消",
                              for: .normal)
        cancelButton.isHidden = true
        addSubview(self.cancelButton)
    }
    
}

