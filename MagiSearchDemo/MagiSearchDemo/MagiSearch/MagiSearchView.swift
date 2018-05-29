//
//  MagiSearchView.swift
//  MagiSearchDemo
//
//  Created by 安然 on 2018/5/28.
//  Copyright © 2018年 MacBook. All rights reserved.
//

import UIKit

class MagiSearchView: UIView {

    open var delegate: MagiSearchDelegate?
    
    open var magiScrollView: UIScrollView!
    
    open var magiSearchMainView: MagiSearchMainView!
    
    open var magiSearchListView: MagiSearchListView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupUI() {
        
        magiScrollView = UIScrollView(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: frame.width,
                                                    height: frame.height))
        
        magiSearchMainView = MagiSearchMainView(frame: CGRect(x: 0,
                                                              y: 0,
                                                              width: frame.width,
                                                              height: frame.height))
        magiSearchMainView.delegate = self
        magiScrollView.addSubview(magiSearchMainView)
        
        magiSearchListView = MagiSearchListView(frame: CGRect(x: 0,
                                                              y: 0,
                                                              width: frame.width,
                                                              height: frame.height))
        magiSearchListView.magiSearchListViewDelegate = self
        magiSearchListView.isHidden = true
        
        if let clearHistoryButton = magiSearchMainView.clearHistoryButton {
            let height = clearHistoryButton.frame.origin.y + clearHistoryButton.frame.height + 20
            
            magiScrollView.contentSize = CGSize(width: frame.width,
                                                height: height)
        } else {
            magiScrollView.contentSize = CGSize(width: frame.width,
                                                height: frame.height)
        }
        magiScrollView.addSubview(magiSearchListView)
        
        addSubview(magiScrollView)
    }
    
    
    func magiSearchMainViewSearchHistoryChanged() {
        let height = magiSearchMainView.clearHistoryButton.frame.origin.y + magiSearchMainView.clearHistoryButton.frame.height + 20
        let size = CGSize(width: frame.width,
                          height: height)
        magiScrollView.contentSize = size
        magiSearchMainView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
    }
    

}

extension MagiSearchView: MagiSearchMainViewDelegate {
    
    func magiCategoryButtonClicked(_ text: String) {
        delegate?.magiCategoryButtonClicked(text)
    }
    
    func magiSearchHistoryButtonClicked(_ text: String) {
        delegate?.magiSearchHistoryButtonClicked(text)
    }

}

extension MagiSearchView: MagiSearchListViewDelegate {

    func scrollViewDidScroll() {
        delegate?.magiSearchListViewDidScroll()
    }
    
    func magiSearchListViewClicked(_ key: String) {
        delegate?.magiSearchListViewClicked(key)
    }
    
    func magiSearchListViewClicked(_ object: Any) {
        delegate?.magiSearchListViewClicked(object)
    }
    
    func magiSearchListView(_ magiSearchListView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = delegate?.magiSearchListView(magiSearchListView, cellForRowAt: indexPath) else { return UITableViewCell() }
        return cell
    }
    
    func magiSearchListView(_ magiSearchListView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.magiSearchListView(magiSearchListView, didSelectRowAt: indexPath)
    }
    
    func magiSearchListViewDidScroll() {
        delegate?.magiSearchListViewDidScroll()
    }
    
}




