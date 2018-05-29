//
//  MagiSearchMainView.swift
//  MagiSearchDemo
//
//  Created by 安然 on 2018/5/28.
//  Copyright © 2018年 MacBook. All rights reserved.
//

import UIKit

open class MagiSearchMainView: UIView {
    
    let width = UIScreen.main.bounds.width
    
    let height = UIScreen.main.bounds.height
    
    var categoryLabel: UILabel!
    
    var magiCategoryButtons = [MagiCategoryButton]()
    
    var searchHistoryLabel: UILabel!
    
    var magiSearchHistoryViews = [MagiSearchHistoryView]()
    
    var magiSearchHistoryButtons = [MagiSearchHistoryButton]()
    
    var clearHistoryButton: UIButton!
    
    var margin: CGFloat = 15
    
    var delegate: MagiSearchMainViewDelegate?
    
    var magiSearch = MagiSearch()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        guard let categories = MagiSearch.shared.getCategories() else { return }
        initView(categories)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setMagiCategoryButtonType(type: MagiCategoryButtonType) {
        for magiCategoryButton in self.magiCategoryButtons {
            magiCategoryButton.type = type
        }
    }
    
    @objc func magiCategoryButtonClicked(_ sender: UIButton) {
        guard let text = magiCategoryButtons[sender.tag].titleLabel?.text else { return }
        magiSearch.appendSearchHistories(value: text)
        delegate?.magiCategoryButtonClicked(text)
    }
    
    @objc func magiSearchHistoryButtonClicked(_ sender: UIButton) {
        guard let text = magiSearchHistoryButtons[sender.tag].textLabel.text else { return }
        delegate?.magiSearchHistoryButtonClicked(text)
    }
    
    @objc func clearHistoryButtonClicked() {
        magiSearch.setSearchHistories(value: [String]())
        redrawSearchHistoryButtons()
    }
    
    @objc func closeButtonClicked(_ sender: UIButton) {
        magiSearch.deleteSearchHistories(index: sender.tag)
        redrawSearchHistoryButtons()
    }
    
    func initView(_ categories: [String]) {
        categoryLabel = UILabel(frame: CGRect(x: margin, y: 0, width: width - 40, height: 50))
        categoryLabel.text = "热门"
        categoryLabel.font = UIFont.systemFont(ofSize: 13)
        categoryLabel.textColor = UIColor.darkGray
        addSubview(categoryLabel)
        
        let font = UIFont.systemFont(ofSize: 12)
        let userAttributes = [NSAttributedStringKey.font : font,
                              NSAttributedStringKey.foregroundColor: UIColor.gray]
        
        var formerWidth: CGFloat = margin
        var formerHeight: CGFloat = 50
        
        for i in 0..<categories.count {
            let size = categories[i].size(withAttributes: userAttributes)
            if i > 0 {
                formerWidth = magiCategoryButtons[i-1].frame.size.width + magiCategoryButtons[i-1].frame.origin.x + 10
                if formerWidth + size.width + margin > UIScreen.main.bounds.width {
                    formerHeight += magiCategoryButtons[i-1].frame.size.height + 10
                    formerWidth = margin
                }
            }
            let button = MagiCategoryButton(frame: CGRect(x: formerWidth, y: formerHeight, width: size.width + 10, height: size.height + 10))
            button.addTarget(self,
                             action: #selector(magiCategoryButtonClicked(_:)),
                             for: .touchUpInside)
            button.setTitle(categories[i], for: .normal)
            button.tag = i
            
            magiCategoryButtons.append(button)
            addSubview(button)
            
        }
        guard let originY = magiCategoryButtons.last?.frame.origin.y else { return }
        searchHistoryLabel = UILabel(frame: CGRect(x: margin,
                                                   y: originY + 30,
                                                   width: width - 40,
                                                   height: 40))
        searchHistoryLabel.text = "搜索历史"
        searchHistoryLabel.font = UIFont.systemFont(ofSize: 13)
        searchHistoryLabel.textColor = UIColor.darkGray
        addSubview(searchHistoryLabel)
        
    }
    
    func redrawSearchHistoryButtons() {
        for magiSearchHistoryView in magiSearchHistoryViews {
            magiSearchHistoryView.removeFromSuperview()
        }
        magiSearchHistoryViews.removeAll()
        magiSearchHistoryButtons.removeAll()
        
        if self.clearHistoryButton != nil {
            self.clearHistoryButton.removeFromSuperview()
        }
        
        let histories = magiSearch.getSearchHistories() ?? [String]()

        let searchHistoryLabelOriginY: CGFloat = searchHistoryLabel.frame.origin.y + searchHistoryLabel.frame.height

        for i in 0..<histories.count {
            let view = MagiSearchHistoryView(frame: CGRect(x: margin, y: searchHistoryLabelOriginY + CGFloat(i * 40) , width: width - (margin * 2), height: 40))
            view.magiSearchHistoryButton.addTarget(self,
                                                   action: #selector(magiSearchHistoryButtonClicked(_:)),
                                                   for: .touchUpInside)
            view.closeButton.addTarget(self,
                                       action: #selector(closeButtonClicked(_:)),
                                       for: .touchUpInside)

            view.magiSearchHistoryButton.textLabel.text = histories[i]
            view.magiSearchHistoryButton.tag = i
            view.closeButton.tag = i

            magiSearchHistoryViews.append(view)
            magiSearchHistoryButtons.append(view.magiSearchHistoryButton)
            addSubview(view)
        }
        var clearHistoryButtonY: CGFloat = 0.0
        if let y = magiSearchHistoryViews.last?.frame.maxY {
            clearHistoryButtonY = y + margin
        }
        else {
            clearHistoryButtonY = searchHistoryLabel.frame.maxY + margin
        }

        clearHistoryButton = UIButton(frame: CGRect(x: margin,
                                                    y: clearHistoryButtonY,
                                                    width: width - (margin * 2),
                                                    height: 40))
        clearHistoryButton.setTitle("清除历史", for: .normal)
        clearHistoryButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        clearHistoryButton.setTitleColor(UIColor.darkGray, for: .normal)
        clearHistoryButton.setTitleColor(UIColor.lightGray, for: .highlighted)
        clearHistoryButton.addTarget(self,
                                     action: #selector(clearHistoryButtonClicked),
                                     for: .touchUpInside)
        addSubview(clearHistoryButton)
        
        delegate?.magiSearchMainViewSearchHistoryChanged()
    }
}

