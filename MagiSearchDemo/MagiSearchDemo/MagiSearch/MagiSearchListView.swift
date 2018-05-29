//
//  MagiSearchListView.swift
//  MagiSearchDemo
//
//  Created by 安然 on 2018/5/28.
//  Copyright © 2018年 MacBook. All rights reserved.
//

import UIKit

class MagiSearchListView: UITableView {
    
    var database = [Any]()
    
    var searchResultDatabase = [Any]()
    
    weak var magiSearchListViewDelegate: MagiSearchListViewDelegate?
    
    var magiSearch = MagiSearch()
    
    var magiSearchTextFieldText: String? {
        didSet {
            guard let text = magiSearchTextFieldText else { return }
            
            let objectification = Objectification(objects: database, type: .all)
            
            let result = objectification.objects(contain: text)
            
            searchResultDatabase = result
            
            if text.isEmpty {
                initData(database: database)
            }
            reloadData()
        }
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupUI() {
        self.delegate = self
        self.dataSource = self
        self.register(MagiSearchListViewCell.self,
                      forCellReuseIdentifier: MagiSearchListViewCell.ID)
    }
    
    func initData(database: [Any]) {
        self.database = database
        self.searchResultDatabase = database
        self.reloadData()
    }
    
    
}

extension MagiSearchListView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = magiSearchListViewDelegate?.magiSearchListView(tableView, cellForRowAt: indexPath) else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultDatabase.count
    }
    
}

extension MagiSearchListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        magiSearchListViewDelegate?.magiSearchListView(tableView, didSelectRowAt: indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        magiSearchListViewDelegate?.magiSearchListViewDidScroll()
    }
    
}

