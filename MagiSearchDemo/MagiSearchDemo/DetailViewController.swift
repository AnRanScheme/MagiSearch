//
//  DetailViewController.swift
//  MagiSearchDemo
//
//  Created by 安然 on 2018/5/28.
//  Copyright © 2018年 MacBook. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var clickedText: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = clickedText
        view.backgroundColor = randomColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func randomColor() -> UIColor {
        
        let colorArray = ["009999", "0099cc", "0099ff", "00cc99", "00cccc", "336699", "3366cc", "3366ff", "339966", "666666", "666699", "6666cc", "6666ff", "996666", "996699", "999900", "999933", "99cc00", "99cc33", "660066", "669933", "990066", "cc9900", "cc6600" , "cc3300", "cc3366", "cc6666", "cc6699", "cc0066", "cc0033", "ffcc00", "ffcc33", "ff9900", "ff9933", "ff6600", "ff6633", "ff6666", "ff6699", "ff3366", "ff3333"]
        
        let randomNumber = arc4random_uniform(UInt32(colorArray.count))
        return UIColor(magihexString: colorArray[Int(randomNumber)])
    }

}
