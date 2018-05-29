//
//  ViewController.swift
//  MagiSearchDemo
//
//  Created by 安然 on 2018/5/28.
//  Copyright © 2018年 MacBook. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func action(_ sender: UIButton) {
        let vc = SearchViewController()
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

