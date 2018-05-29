//
//  MagiSearchHistoryButton.swift
//  MagiSearchDemo
//
//  Created by 安然 on 2018/5/28.
//  Copyright © 2018年 MacBook. All rights reserved.
//

import UIKit

class MagiSearchHistoryView: UIView {
    
    var magiSearchHistoryButton: MagiSearchHistoryButton!
    
    var closeButton: UIButton!
    
    var bottomLine: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupUI() {
        magiSearchHistoryButton = MagiSearchHistoryButton(frame: CGRect(x: 0,
                                                                             y: 0,
                                                                             width: frame.width - 15,
                                                                             height: frame.height))
        addSubview(magiSearchHistoryButton)
        
        closeButton = UIButton(frame: CGRect(x: frame.width - 15,
                                             y: (frame.height - 15)/2,
                                             width: 15,
                                             height: 15))
        let close = UIImage(named: "close",
                            in: Bundle(for: MagiSearch.self),
                            compatibleWith: nil)
        
        closeButton.setImage(close, for: .normal)
        addSubview(closeButton)
        
        bottomLine = UIView(frame: CGRect(x: 0,
                                          y: frame.height-1,
                                          width: frame.width,
                                          height: 1))
        bottomLine.backgroundColor = UIColor(red: 242.0/255.0,
                                             green: 242.0/255.0,
                                             blue: 242.0/255.0,
                                             alpha: 1.0)
        addSubview(bottomLine)
        
    }
}

class MagiSearchHistoryButton: UIButton {
    
    var textLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var isHighlighted: Bool {
        didSet {
            switch isHighlighted {
            case true:
                textLabel.textColor = UIColor.darkGray.withAlphaComponent(0.3)
            case false:
                textLabel.textColor = UIColor.darkGray
            }
        }
    }
    
    private func setupUI() {
        let searchHistoryImageview = UIImageView(frame: CGRect(x: 0,
                                                               y: (self.frame.height - 15)/2,
                                                               width: 15,
                                                               height: 15))
        let search_history = UIImage(named: "search_history",
                                     in: Bundle(for: MagiSearch.self),
                                     compatibleWith: nil)
        searchHistoryImageview.image = search_history
        addSubview(searchHistoryImageview)
        
        textLabel = UILabel(frame: CGRect(x: 25, y: 0,
                                          width: self.frame.width - 40,
                                          height: self.frame.height))
        textLabel.font = UIFont.systemFont(ofSize: 14)
        textLabel.textColor = UIColor.darkGray
        addSubview(textLabel)
        
    }
    
}
