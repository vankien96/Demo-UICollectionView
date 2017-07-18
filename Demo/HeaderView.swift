//
//  HeaderView.swift
//  Demo
//
//  Created by TPPFIT iCloud on 7/15/17.
//  Copyright © 2017 TPPFIT iCloud. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {
    @IBOutlet var imgCategory: UIImageView!
    @IBOutlet var lbCategory: UILabel!
    var imageName:String!{
        didSet{
            imgCategory.image = UIImage(named: imageName)
        }
    }
    var titleCategory:String!{
        didSet{
            lbCategory.text = titleCategory
        }
    }
    
}
