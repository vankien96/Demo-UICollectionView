//
//  PhotoCell.swift
//  Demo
//
//  Created by TPPFIT iCloud on 7/14/17.
//  Copyright © 2017 TPPFIT iCloud. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var viewDeleteButton: UIVisualEffectView!
    @IBOutlet var viewDelete: UIView!
    
    var imageName:String!{
        didSet{
            imgView.image = UIImage.init(named: imageName)
            viewDeleteButton.layer.cornerRadius = 10
            viewDeleteButton.layer.masksToBounds = true
            viewDeleteButton.isHidden = true
        }
    }
    var editing:Bool = false{
        didSet{
            viewDeleteButton.isHidden = !editing
        }
    }
    @IBAction func clickOnButtonDelete(_ sender: Any) {
        
    }
}
