//
//  SearchViewController.swift
//  MagiSearchDemo
//
//  Created by 安然 on 2018/5/28.
//  Copyright © 2018年 MacBook. All rights reserved.
//

import UIKit


class SearchViewController: MagiSearchViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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

        let database1 = "MagiDropDownMenu"
        let database2 = "MagiSearchData"
        let database3 = "MagiExpandableCell"
        let demoDatabase = [database1, database2, database3]
        
        initData(demoDatabase)
        setMagiCategoryButtonType(type: .colorful)
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
        // magiSearchTextfieldView.magiSearchTextField.endEditing(true)
        searchBar?.resignFirstResponder()
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
