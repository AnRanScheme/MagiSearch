//
//  MagiSearchView.swift
//  MagiSearchDemo
//
//  Created by 安然 on 2018/5/28.
//  Copyright © 2018年 MacBook. All rights reserved.
//

import UIKit

class MagiSearchView: UIView {

    weak var delegate: MagiSearchDelegate?
    
    var searchBar: UISearchBar?
    
    var magiScrollView: UIScrollView!
    
    var magiSearchMainView: MagiSearchMainView!
    
    var magiSearchListView: MagiSearchListView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupUI() {
        
        magiScrollView = UIScrollView(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width:  magi_width,
                                                    height: frame.height))
        magiScrollView.bounces = true
        magiSearchMainView = MagiSearchMainView(frame: CGRect(x: 0,
                                                              y: 0,
                                                              width:  magi_width,
                                                              height: frame.height))
        magiSearchMainView.delegate = self
        magiScrollView.addSubview(magiSearchMainView)
        
        magiSearchListView = MagiSearchListView(frame: CGRect(x: 0,
                                                              y: 0,
                                                              width:  magi_width,
                                                              height: frame.height))
        magiSearchListView.magiSearchListViewDelegate = self
        magiSearchListView.isHidden = true
        if let clearHistoryButton = magiSearchMainView.clearHistoryButton,
            frame.height < clearHistoryButton.frame.maxY + 20{
            let height = clearHistoryButton.frame.maxY + 20
            
            magiScrollView.contentSize = CGSize(width:  magi_width,
                                                height: height)
        } else {
            magiScrollView.contentSize = CGSize(width:  magi_width,
                                                height: frame.height)
        }
        magiScrollView.delegate = self
        magiScrollView.addSubview(magiSearchListView)
        
        addSubview(magiScrollView)
    }
    
    
    func magiSearchMainViewSearchHistoryChanged() {
        let height = magiSearchMainView.clearHistoryButton.frame.maxY + 20
        if height < magi_height {
            magiScrollView.contentSize = CGSize(width: magi_width,
                                                height: magi_height)
            magiSearchMainView.frame = CGRect(origin: CGPoint(x: 0,
                                                              y: 0),
                                              size: CGSize(width: magi_width,
                                                           height: magi_height))
        }
        else {
            let size = CGSize(width:  magi_width,
                              height: height)
            magiScrollView.contentSize = size
            magiSearchMainView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        }
       
    }
    

}

extension MagiSearchView: MagiSearchMainViewDelegate {
    
    func magiCategoryButtonClicked(_ text: String) {
        searchBar?.text = text
        searchBar?.resignFirstResponder()
        MagiSearch.shared.appendSearchHistories(value: text)
        magiSearchMainView.redrawSearchHistoryButtons()
        delegate?.magiCategoryButtonClicked(text)
    }
    
    func magiSearchHistoryButtonClicked(_ text: String) {
        searchBar?.text = text
        searchBar?.resignFirstResponder()
        MagiSearch.shared.appendSearchHistories(value: text)
        magiSearchMainView.redrawSearchHistoryButtons()
        delegate?.magiSearchHistoryButtonClicked(text)
    }

}

extension MagiSearchView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar?.resignFirstResponder()
        delegate?.magiSearchListViewDidScroll()
    }
}

extension MagiSearchView: MagiSearchListViewDelegate {
    
    func magiSearchListViewDidScroll() {
        searchBar?.resignFirstResponder()
    }

    func magiSearchListViewClicked(_ key: String) {
        searchBar?.resignFirstResponder()
        delegate?.magiSearchListViewClicked(key)
    }
    
    func magiSearchListView(_ magiSearchListView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = delegate?.magiSearchListView(magiSearchListView, cellForRowAt: indexPath) else { return UITableViewCell() }
        return cell
    }
    
    func magiSearchListView(_ magiSearchListView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.magiSearchListView(magiSearchListView, didSelectRowAt: indexPath)
    }
    
    
}




