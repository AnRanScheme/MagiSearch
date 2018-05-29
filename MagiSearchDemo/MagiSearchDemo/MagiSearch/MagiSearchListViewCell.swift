//
//  MagiSearchListViewCell.swift
//  MagiSearchDemo
//
//  Created by 安然 on 2018/5/28.
//  Copyright © 2018年 MacBook. All rights reserved.
//

import UIKit

class MagiSearchListViewCell: UITableViewCell {
    
    static let ID = "MagiSearchListViewCell"
    
    var leftMargin = 15
    
    var searchImageView: UIImageView!
    
    var searchLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupUI() {
        searchImageView = UIImageView(frame: CGRect(x: 15,
                                                    y: ( frame.height - 15)/2,
                                                    width: 15,
                                                    height: 15))
        let search = UIImage(named: "search",
                             in: Bundle(for: MagiSearch.self),
                             compatibleWith: nil)
        searchImageView.image = search
        addSubview(searchImageView)
        
        searchLabel = UILabel(frame: CGRect(x: 40,
                                            y: 0,
                                            width:   magi_width - 20,
                                            height:  frame.height))
        searchLabel.textColor = UIColor.darkGray
        searchLabel.font = UIFont.systemFont(ofSize: 13)
        addSubview(searchLabel)
    }
    
    
}
