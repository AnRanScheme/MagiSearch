//
//  MagiSearchDelegate.swift
//  MagiSearchDemo
//
//  Created by 安然 on 2018/5/28.
//  Copyright © 2018年 MacBook. All rights reserved.
//

import UIKit

public protocol MagiSearchDelegate: MagiSearchMainViewDelegate, MagiSearchListViewDelegate {
    
}


public protocol MagiSearchMainViewDelegate {
    
    func magiCategoryButtonClicked(_ text: String)
    
    func magiSearchHistoryButtonClicked(_ text: String)
    
    func magiSearchMainViewSearchHistoryChanged()
    
}

public protocol MagiSearchListViewDelegate {
    
    func magiSearchListViewClicked(_ key: String)
    
    func magiSearchListViewClicked(_ object: Any)
    
    func magiSearchListView(_ magiSearchListView: UITableView, didSelectRowAt indexPath: IndexPath)
    
    func magiSearchListView(_ magiSearchListView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    
    func magiSearchListViewDidScroll()

}

public extension MagiSearchMainViewDelegate {
    
    func magiSearchMainViewSearchHistoryChanged() {
        
    }
    
}

public extension MagiSearchListViewDelegate {
    
    func magiSearchListViewClicked(_ object: Any) {
        
    }
    
    func magiSearchListViewDidScroll() {
        
    }
    
}



