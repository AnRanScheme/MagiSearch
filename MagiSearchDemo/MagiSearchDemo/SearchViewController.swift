//
//  SearchViewController.swift
//  MagiSearchDemo
//
//  Created by 安然 on 2018/5/28.
//  Copyright © 2018年 MacBook. All rights reserved.
//

import UIKit

class MagiDropDownMenu: MagiSearchModel {
    var starCount = 512
    var description = "Awesome Dropdown menu for iOS with Swift 3"
    var version = "2.3.0"
    var url = "https://github.com/younatics/magiDropDownMenu"
}

class MagiSearchData: MagiSearchModel {
    var title = "magiSearch"
    var starCount = 271
    var description = "Awesome fully customize search view like Pinterest written in Swift 3"
    var version = "0.3.1"
    var url = "https://github.com/younatics/magiSearch"
}

class MagiExpandableCell: MagiSearchModel {
    var title = "magiExpandableCell"
    var starCount = 191
    var description = "Awesome expandable, collapsible tableview cell for iOS written in Swift 3"
    var version = "1.1.0"
    var url = "https://github.com/younatics/magiExpandableCell"
}

class SearchViewController: MagiSearchViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let demoCategories = ["Menu", "Animation", "Transition", "TableView", "CollectionView", "Indicator", "Alert", "UIView", "UITextfield", "UITableView", "Swift", "iOS", "Android"]
        let demoSearchHistories = ["Menu", "Animation", "Transition", "TableView"]
        
        let magiSearch = MagiSearch()
        magiSearch.setCategories(value: demoCategories)
        magiSearch.setSearchHistories(value: demoSearchHistories)
        magiSearchInit()
        self.delegate = self

        let database1 = MagiDropDownMenu("MagiDropDownMenu")
        let database2 = MagiSearchData("MagiSearchData")
        let database3 = MagiExpandableCell("MagiExpandableCell")
        let demoDatabase = [database1, database2, database3]
        
        initData(demoDatabase)
        setmagiCategoryButtonType(type: .colorful)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func pushViewController(_ text:String) {
        let vc = DetailViewController()
        vc.clickedText = text
        navigationController?.pushViewController(vc, animated: true)
    }


}

extension SearchViewController {
    
    func magiSearchListViewDidScroll() {
        magiSearchTextfieldView.magiSearchTextField.endEditing(true)
    }
    
    
    
}

extension SearchViewController: MagiSearchDelegate {
    
    func magiCategoryButtonClicked(_ text: String) {
        pushViewController(text)
    }
    
    func magiSearchHistoryButtonClicked(_ text: String) {
        pushViewController(text)
    }
    
    func magiSearchListViewClicked(_ key: String) {
        print("\(key)")
    }
    
    func magiSearchListView(_ magiSearchListView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let magimodel = magiSearchView.magiSearchListView.searchResultDatabase[indexPath.row] as? MagiSearchModel,
            let key = magimodel.key {
            magiSearchView.magiSearchListView.magiSearchListViewDelegate?.magiSearchListViewClicked(key)
           magiSearchView.magiSearchListView.magiSearchListViewDelegate?.magiSearchListViewClicked(magiSearchView.magiSearchListView.database[indexPath.row])
            magiSearchView.magiSearchListView.magiSearch.appendSearchHistories(value: key)
        }
    }
    
    func magiSearchListView(_ magiSearchListView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = magiSearchView.magiSearchListView.dequeueReusableCell(withIdentifier: MagiSearchListViewCell.ID) as! MagiSearchListViewCell
        if let magimodel = magiSearchView.magiSearchListView.searchResultDatabase[indexPath.row] as? MagiSearchModel {
            cell.searchLabel.text = magimodel.key
        }
        
        return cell
    }
    
    
}
