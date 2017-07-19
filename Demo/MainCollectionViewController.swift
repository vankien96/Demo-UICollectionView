//
//  MainCollectionViewController.swift
//  Demo
//
//  Created by TPPFIT iCloud on 7/15/17.
//  Copyright © 2017 TPPFIT iCloud. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PhotoCell"

class MainCollectionViewController: UICollectionViewController,PhotoCellDelegate{

    @IBOutlet var btnAdd: UIBarButtonItem!
    var libraryImage:[photoCategory] = PhotoData.convertData()
    var naviL:UIBarButtonItem?
    var naviR:UIBarButtonItem?
    let leftAndRightPaddings:CGFloat = 2.0
    let numberOfRowInALine:CGFloat = 3.0
    var oldFrame:CGRect!
    var indexPath:IndexPath!
    var editingImage:Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        let collectionViewWidth:CGFloat = (collectionView?.frame.width)!
        let itemWidth = (collectionViewWidth - self.leftAndRightPaddings)/self.numberOfRowInALine
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        self.navigationItem.leftBarButtonItem = editButtonItem
        self.navigationController?.navigationBar.tintColor = UIColor.white
        naviL = self.navigationItem.leftBarButtonItem
        naviR = self.navigationItem.rightBarButtonItem
        editingImage = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return libraryImage.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return libraryImage[section].imageNames.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
         //Configure the cell
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                cell.imgView.image = UIImage(named: self.libraryImage[indexPath.section].imageNames[indexPath.row])
            }
        }
        cell.delegate = self as! PhotoCellDelegate
        if editingImage{
            cell.viewDeleteButton.isHidden = false
        }else{
            cell.viewDeleteButton.isHidden = true
        }
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderView
        headerView.imageName = libraryImage[indexPath.section].categoryIconName
        headerView.titleCategory = libraryImage[indexPath.section].categoryName
        return headerView
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? PhotoCell
        cell?.superview?.bringSubview(toFront: cell!)
        self.indexPath = indexPath
        collectionView.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.5 , delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveLinear, animations: {
            self.oldFrame = cell?.frame
            cell?.frame = collectionView.bounds
            collectionView.isScrollEnabled = false
            let button = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.clickToBack(_:)))
            self.navigationItem.leftBarButtonItem = button
            self.navigationItem.rightBarButtonItem = nil
            self.view.layoutIfNeeded()
            self.navigationItem.title = "Detail"
        }, completion: nil)
    }
    func clickToBack(_  button:UIButton){
        print("BACK")
        collectionView?.isScrollEnabled = true
        let cell = collectionView?.cellForItem(at: indexPath)
        collectionView?.isUserInteractionEnabled = true
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveLinear, animations: {
            cell?.frame = self.oldFrame
            self.view.layoutIfNeeded()
            self.navigationItem.leftBarButtonItem = self.naviL
            self.navigationItem.rightBarButtonItem = self.naviR
            self.navigationItem.title = "Photos"
        }, completion: nil)
    }
    @IBAction func addItemWhenTap(_ sender: Any) {
        var firstImageNames = libraryImage[0].imageNames
        let random = Int(arc4random_uniform(UInt32(firstImageNames.count)))
        let randomImage = firstImageNames[random]
        self.libraryImage[0].imageNames.append(randomImage)
        
        
        let insertItem = IndexPath(row: firstImageNames.count, section: 0)
        self.collectionView?.insertItems(at: [insertItem])
    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        btnAdd.isEnabled = !editing
        editingImage = editing
        UpdateCollectionView()
    }
    func UpdateCollectionView(){
        if editingImage{
            for i in 0..<libraryImage.count{
                for j in 0..<libraryImage[i].imageNames.count{
                    let index = IndexPath(row: j, section: i)
                    if let cell = collectionView?.cellForItem(at: index) as? PhotoCell{
                        UIView.transition(with: cell.viewDeleteButton, duration: 0.5, options: .transitionCrossDissolve, animations: {
                            cell.viewDeleteButton.isHidden = false
                        }, completion: nil)
                    }
                }
            }
        }else{
            for i in 0..<libraryImage.count{
                for j in 0..<libraryImage[i].imageNames.count{
                    let index = IndexPath(row: j, section: i)
                    if let cell = collectionView?.cellForItem(at: index) as? PhotoCell{
                        UIView.transition(with: cell.viewDeleteButton, duration: 0.5, options: .curveLinear, animations: {
                            cell.viewDeleteButton.isHidden = true
                        }, completion: nil)
                    }
                }
            }

        }
    }
    func deleteCell(cell: PhotoCell) {
        print("delete")
        let indexPath = collectionView?.indexPath(for: cell)
        libraryImage[(indexPath?.section)!].imageNames.remove(at: (indexPath?.item)!)
        collectionView?.deleteItems(at: [indexPath!])
    }
    
}
