//
//  MagiCategoryButton.swift
//  MagiSearchDemo
//
//  Created by 安然 on 2018/5/28.
//  Copyright © 2018年 MacBook. All rights reserved.
//

import UIKit


enum MagiHotSearchStyle: Int {
    case normal = 0
    case colorful = 1
    case border = 2
    case arcBorder = 3
    case rank = 4
    case rectang = 5
}

open class MagiCategoryButton: UIButton {
    
    var type: MagiHotSearchStyle? {
        didSet {
            guard let _type = type else { return }
            setType(_type)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open var isHighlighted: Bool {
        didSet {
            if let type = self.type {
                switch type {
                case .border:
                    switch isHighlighted {
                    case true:
                        layer.borderColor = UIColor.lightGray.cgColor
                    case false:
                        layer.borderColor = UIColor.darkGray.cgColor
                    }
                    
                case .colorful:
                    switch isHighlighted {
                    case true:
                        layer.borderColor = UIColor.lightGray.cgColor
                    case false:
                        layer.borderColor = UIColor.white.cgColor
                    }
                case .normal:
                    break
                case .arcBorder:
                    break
                case .rank:
                    break
                case .rectang:
                    break
                }
                
            } else {
                switch isHighlighted {
                case true:
                    layer.borderColor = UIColor.lightGray.cgColor
                case false:
                    layer.borderColor = UIColor.darkGray.cgColor
                }
            }
        }
    }
    
    private func setupUI() {
        layer.borderColor = UIColor.darkGray.cgColor
        layer.borderWidth = 1
        titleLabel?.font = UIFont.systemFont(ofSize: 12)
       setTitleColor(UIColor.darkGray, for: .normal)
       setTitleColor(UIColor.lightGray, for: .highlighted)
        layer.cornerRadius = frame.height * 0.1
    }
    
    func setType(_ type: MagiHotSearchStyle) {
        
        switch type {
        case .normal:
            layer.borderColor = nil
            layer.borderWidth = 0
            backgroundColor = UIColor.init(red: 246.0/255.0, green: 246.0/255.0, blue: 246.0/255.0, alpha: 1)
            setTitleColor(UIColor.darkGray, for: .normal)
            setTitleColor(UIColor.darkGray.withAlphaComponent(0.3), for: .highlighted)
            
        case .border:
            layer.borderColor = UIColor.darkGray.cgColor
            layer.borderWidth = 1
            setTitleColor(UIColor.darkGray, for: .normal)
            setTitleColor(UIColor.darkGray.withAlphaComponent(0.3), for: .highlighted)
            
        case .colorful:
            layer.borderColor = nil
            layer.borderWidth = 0
            backgroundColor = randomColor()
            setTitleColor(UIColor.white, for: .normal)
            setTitleColor(UIColor.white.withAlphaComponent(0.3), for: .highlighted)
        case .arcBorder:
            break
        case .rank:
            break
        case .rectang:
            break
        }
        
    }
    
    open func randomColor() -> UIColor {
        
        let colorArray = ["009999", "0099cc", "0099ff", "00cc99", "00cccc", "336699", "3366cc", "3366ff", "339966", "666666", "666699", "6666cc", "6666ff", "996666", "996699", "999900", "999933", "99cc00", "99cc33", "660066", "669933", "990066", "cc9900", "cc6600" , "cc3300", "cc3366", "cc6666", "cc6699", "cc0066", "cc0033", "ffcc00", "ffcc33", "ff9900", "ff9933", "ff6600", "ff6633", "ff6666", "ff6699", "ff3366", "ff3333"]
        
        let randomNumber = arc4random_uniform(UInt32(colorArray.count))
        return UIColor(magihexString: colorArray[Int(randomNumber)])
    }
    
    
}

