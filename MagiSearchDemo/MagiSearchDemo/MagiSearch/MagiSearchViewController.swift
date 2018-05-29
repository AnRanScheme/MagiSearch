//
//  MagiSearchViewController.swift
//  MagiSearchDemo
//
//  Created by 安然 on 2018/5/28.
//  Copyright © 2018年 MacBook. All rights reserved.
//

import UIKit

class MagiSearchViewController: UIViewController {
    
    weak var delegate: MagiSearchDelegate? {
        didSet {
            magiSearchView.delegate = delegate
        }
    }
    
    let width = UIScreen.main.bounds.width
    
    let height = UIScreen.main.bounds.height
    
    var magiSearchTextfieldView: MagiSearchTextFieldView!
    
    var magiSearchView: MagiSearchView!
    
    var magiSerach = MagiSearch.shared
    
    var searchBar: UISearchBar?
    
    var searchTextField: UITextField?
    
    fileprivate var currentOrientation: UIDeviceOrientation = UIDevice.current.orientation
    
    fileprivate var cancelButtonWidth: CGFloat = 0.0

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar?.becomeFirstResponder()
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if currentOrientation != UIDevice.current.orientation {
            // orientation changed, reload layout
            currentOrientation = UIDevice.current.orientation
        }

        guard let cancelButton = navigationItem.rightBarButtonItem?.customView else {return}
        cancelButtonWidth = cancelButton.magi_width > cancelButtonWidth ? cancelButton.magi_width : cancelButtonWidth
        
        if UIDevice.current.systemVersion >= "11.0" {
            guard let navBar = navigationController?.navigationBar else {return}
            navBar.layoutMargins = .zero
            let space: CGFloat = 8
            for subview in navBar.subviews {
                if NSStringFromClass(subview.classForCoder).contains("ContentView") {
                    subview.layoutMargins = UIEdgeInsetsMake(0, space, 0, space)
                    break
                }
            }
            searchBar?.magi_width = view.magi_width - cancelButtonWidth - magi_margin * 3 - 8
            searchBar?.magi_height = view.magi_width > view.magi_height ? 24 : 30
            searchTextField?.frame = searchBar?.bounds ?? CGRect.zero
        } else {
            guard let titleView = self.navigationItem.titleView else { return }
            titleView.magi_x = magi_margin * 1.5
            titleView.magi_y = view.magi_width > view.magi_height ? 3 : 7
            titleView.magi_width = view.magi_width - cancelButtonWidth - titleView.magi_x * 2 - 3
            titleView.magi_height = view.magi_width > view.magi_height ? 24 : 30
        }
        
    }
    
    deinit {
        print(self.debugDescription + " --- 销毁了")
    }
    
    func magiSearchInit() {
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.backIndicatorImage = nil
        
        let cancleButton = UIButton(type: UIButtonType.system)
        cancleButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        cancleButton.setTitle("取消",
                              for: .normal)
        cancleButton.addTarget(self,
                               action: #selector(cancelDidClick),
                               for: .touchUpInside)
        cancleButton.sizeToFit()
        cancleButton.magi_width += magi_margin
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cancleButton)
        
        let titleView = UIView()
        let searchBar = UISearchBar(frame: titleView.bounds)
        titleView.addSubview(searchBar)
        if UIDevice.current.systemVersion >= "11.0" {
            NSLayoutConstraint.activate([searchBar.topAnchor.constraint(equalTo: titleView.topAnchor),
                                         searchBar.leftAnchor.constraint(equalTo: titleView.leftAnchor),
                                         searchBar.rightAnchor.constraint(equalTo: titleView.rightAnchor,
                                                                          constant: -magi_margin),
                                         searchBar.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
                                         ])
        } else {
            searchBar.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        }
        navigationItem.titleView = titleView
        searchBar.placeholder = "年后"
        searchBar.backgroundImage = UIImage(named: "clearImage",
                                            in: Bundle(for: MagiSearch.self),
                                            compatibleWith: nil)
        self.searchBar = searchBar
        
        searchBar.subviews.last?.subviews.forEach{
            if $0.isKind(of: UITextField.classForCoder()) {
                self.searchTextField = $0 as? UITextField
            }
        }
        
        searchBar.delegate = self
        magiSearchView = MagiSearchView(frame: CGRect(x: 0,
                                                      y: 0,
                                                      width: width,
                                                      height: height))
        magiSearchView.searchBar = searchBar
        view.addSubview(magiSearchView)

    }
    /*
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
    }*/
    
    
    
    func setMagiCategoryButtonType(type: MagiHotSearchStyle) {
        magiSearchView.magiSearchMainView.setMagiCategoryButtonType(type: .colorful)
    }
    
    func initData(_ database: [Any]) {
        magiSearchView.magiSearchListView.initData(database: database)
    }
    
    @objc func cancelDidClick() {
        searchBar?.resignFirstResponder()
        dismiss(animated: true, completion: nil)
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

extension MagiSearchViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        if !text.isEmpty {
            magiSerach.appendSearchHistories(value: text)
            magiSearchView.magiSearchMainView.redrawSearchHistoryButtons()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("\(searchText)")
        if 0 == searchText.count {
            UIView.animate(withDuration: 0.3, animations: {
                self.magiSearchView.magiSearchMainView.alpha = 1
                self.magiSearchView.magiSearchListView.alpha = 0
            }) { (true) in
                self.magiSearchView.magiSearchMainView.isHidden = false
                self.magiSearchView.magiSearchListView.isHidden = true
            }
        }
        
        else {
            UIView.animate(withDuration: 0.3, animations: {
                self.magiSearchView.magiSearchMainView.alpha = 0
                self.magiSearchView.magiSearchListView.alpha = 1
            }) { (true) in
                self.magiSearchView.magiSearchMainView.isHidden = true
                self.magiSearchView.magiSearchListView.isHidden = false
            }
        }
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










