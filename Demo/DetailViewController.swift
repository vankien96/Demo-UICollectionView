//
//  DetailViewController.swift
//  Demo
//
//  Created by TPPFIT iCloud on 7/15/17.
//  Copyright © 2017 TPPFIT iCloud. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imgDetail: UIImageView!
    var imageName:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Detail"
        self.navigationController?.navigationBar.tintColor = UIColor.white
        imgDetail.image = UIImage(named: imageName)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
