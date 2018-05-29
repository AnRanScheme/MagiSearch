//
//  MagiSearchListViewCell.swift
//  MagiSearchDemo
//
//  Created by 安然 on 2018/5/28.
//  Copyright © 2018年 MacBook. All rights reserved.
//

import UIKit

open class MagiSearchListViewCell: UITableViewCell {
    
    open static let ID = "MagiSearchListViewCell"
    
    var leftMargin = 15
    
    open var searchImageView: UIImageView!
    
    open var searchLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupUI() {
        self.searchImageView = UIImageView(frame: CGRect(x: 15, y: (self.frame.height - 15)/2, width: 15, height: 15))
        let search = UIImage(named: "search", in: Bundle(for: MagiSearch.self), compatibleWith: nil)
        self.searchImageView.image = search
        self.addSubview(searchImageView)
        
        self.searchLabel = UILabel(frame: CGRect(x: 40, y: 0, width: self.frame.width - 20, height: self.frame.height))
        self.searchLabel.textColor = UIColor.darkGray
        self.searchLabel.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(searchLabel)
    }
    
    
}
