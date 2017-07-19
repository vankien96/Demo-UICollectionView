//
//  PhotoCell.swift
//  Demo
//
//  Created by TPPFIT iCloud on 7/14/17.
//  Copyright © 2017 TPPFIT iCloud. All rights reserved.
//

import UIKit
protocol PhotoCellDelegate{
    func deleteCell(cell:PhotoCell)
}
class PhotoCell: UICollectionViewCell {
    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var viewDeleteButton: UIVisualEffectView!
    @IBOutlet var viewDelete: UIView!
    var delegate:PhotoCellDelegate? = nil
    override func awakeFromNib() {
        viewDeleteButton.layer.cornerRadius = 10
        imgView.layer.cornerRadius = 10
        viewDeleteButton.layer.masksToBounds = true
        viewDeleteButton.isHidden = true
    }
    @IBAction func clickOnButtonDelete(_ sender: Any) {
        
        if(delegate != nil){
            print("delete delegate")
            delegate?.deleteCell(cell: self)
        }else{
            print("nil")
        }
    }
}
