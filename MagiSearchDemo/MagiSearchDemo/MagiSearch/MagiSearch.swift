//
//  MagiSearch.swift
//  MagiSearchDemo
//
//  Created by 安然 on 2018/5/28.
//  Copyright © 2018年 MacBook. All rights reserved.
//

import UIKit

open class MagiSearch: NSObject {
    
    var pref: UserDefaults!
    
    static let shared: MagiSearch = MagiSearch()

    public override init() {
        pref = UserDefaults.standard
    }
    
    open func setCategories(value: [String]) {
        pref.set(value, forKey: "categories")
    }
    
    open func getCategories() -> [String]? {
        guard let categories = pref.object(forKey: "categories") as? [String] else { return nil }
        return categories
    }
    
    open func setSearchHistories(value: [String]) {
        pref.set(value, forKey: "histories")
    }
    
    open func deleteSearchHistories(index: Int) {
        guard var histories = pref.object(forKey: "histories") as? [String] else { return }
        histories.remove(at: index)
        
        pref.set(histories, forKey: "histories")
    }
    
    func appendSearchHistories(value: String) {
        var histories = [String]()
        if let _histories = pref.object(forKey: "histories") as? [String] {
            histories = _histories
        }

        for (index, ele) in histories.enumerated() {
            if ele == value {
                histories.remove(at: index)
            }
        }
        histories.append(value)
//
//        let array = histories.filterDuplicates{
//            $0
//        }
        pref.set(histories, forKey: "histories")
    }
    
    func getSearchHistories() -> [String]? {
        guard let histories = pref.object(forKey: "histories") as? [String] else { return nil }
        return histories.reversed()
    }
    
    
}
