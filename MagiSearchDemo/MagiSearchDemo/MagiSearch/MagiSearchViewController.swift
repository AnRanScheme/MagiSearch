//
//  MagiSearchViewController.swift
//  MagiSearchDemo
//
//  Created by 安然 on 2018/5/28.
//  Copyright © 2018年 MacBook. All rights reserved.
//

import UIKit

class MagiSearchViewController: UIViewController {
    
    var delegate: MagiSearchDelegate? {
        didSet {
            magiSearchView.delegate = delegate
        }
    }
    
    let width = UIScreen.main.bounds.width
    
    let height = UIScreen.main.bounds.height
    
    var magiSearchTextfieldView: MagiSearchTextFieldView!
    
    var magiSearchView: MagiSearchView!
    
    var magiSerach = MagiSearch()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func magiSearchInit() {
        magiSearchTextfieldView = MagiSearchTextFieldView(frame: CGRect(x: 20,
                                                                        y: 20,
                                                                        width: width-40,
                                                                        height: 50))
        magiSearchTextfieldView.magiSearchTextField.delegate = self
        magiSearchTextfieldView.magiSearchTextField.addTarget(self,
                                                              action: #selector(magiSearchTextfieldTextChanged(_:)),
                                                              for: .editingChanged)
        magiSearchTextfieldView.cancelButton.addTarget(self,
                                                       action: #selector(magiSearchTextfieldcancelButtonClicked),
                                                       for: .touchUpInside)
        
        magiSearchTextfieldView.magiSearchTextField.clearButtonMode = .whileEditing
        
        view.addSubview(magiSearchTextfieldView)
        
        magiSearchView = MagiSearchView(frame: CGRect(x: 0,
                                                      y: 70,
                                                      width: width,
                                                      height: height-70))
        view.addSubview(magiSearchView)
    }
    
    func setmagiCategoryButtonType(type: MagiCategoryButtonType) {
        magiSearchView.magiSearchMainView.setMagiCategoryButtonType(type: .colorful)
    }
    
    func initData(_ database: [Any]) {
        magiSearchView.magiSearchListView.initData(database: database)
    }
    
    @objc func magiSearchTextfieldcancelButtonClicked() {
        magiSearchTextfieldView.magiSearchTextField.text = ""
        magiSearchTextfieldView.magiSearchTextField.endEditing(true)
        magiSearchView.magiSearchMainView.redrawSearchHistoryButtons()
        
        UIView.animate(withDuration: 0.3, animations: {
            self.magiSearchView.magiSearchMainView.alpha = 1
            self.magiSearchTextfieldView.cancelButton.alpha = 0
            self.magiSearchView.magiSearchListView.alpha = 0
        }) { (true) in
            self.magiSearchView.magiSearchMainView.isHidden = false
            self.magiSearchView.magiSearchListView.isHidden = true
            self.magiSearchTextfieldView.cancelButton.isHidden = true
        }
    }
    
    @objc func magiSearchTextfieldTextChanged(_ textField: UITextField) {
        magiSearchView.magiSearchListView.magiSearchTextFieldText = textField.text
    }
    
}

extension MagiSearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return true }
        if !text.isEmpty {
            magiSerach.appendSearchHistories(value: text)
            magiSearchView.magiSearchMainView.redrawSearchHistoryButtons()
        }
        magiSearchTextfieldView.magiSearchTextField.endEditing(true)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3, animations: {
            self.magiSearchView.magiSearchMainView.alpha = 0
            self.magiSearchTextfieldView.cancelButton.alpha = 1
            self.magiSearchView.magiSearchListView.alpha = 1
        }) { (true) in
            self.magiSearchView.magiSearchMainView.isHidden = true
            self.magiSearchView.magiSearchListView.isHidden = false
            self.magiSearchTextfieldView.cancelButton.isHidden = false
        }
    }
    
}










