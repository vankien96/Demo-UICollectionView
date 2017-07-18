//
//  MainCollectionViewController.swift
//  Demo
//
//  Created by TPPFIT iCloud on 7/15/17.
//  Copyright © 2017 TPPFIT iCloud. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PhotoCell"

class MainCollectionViewController: UICollectionViewController{

    @IBOutlet var btnAdd: UIBarButtonItem!
    var libraryImage:[photoCategory] = PhotoData.convertData()
    
    let leftAndRightPaddings:CGFloat = 2.0
    let numberOfRowInALine:CGFloat = 3.0
    override func viewDidLoad() {
        super.viewDidLoad()
        let collectionViewWidth:CGFloat = (collectionView?.frame.width)!
        let itemWidth = (collectionViewWidth - self.leftAndRightPaddings)/self.numberOfRowInALine
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        self.navigationItem.leftBarButtonItem = editButtonItem
        self.navigationController?.navigationBar.tintColor = UIColor.white
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
        // Configure the cell
        cell.imageName = self.libraryImage[indexPath.section].imageNames[indexPath.row]
    
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderView
        headerView.imageName = libraryImage[indexPath.section].categoryIconName
        headerView.titleCategory = libraryImage[indexPath.section].categoryName
        return headerView
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detail = self.storyboard?.instantiateViewController(withIdentifier: "DetailController") as! DetailViewController
        detail.imageName = libraryImage[indexPath.section].imageNames[indexPath.row]
        self.navigationController?.pushViewController(detail, animated: true)
    }
    @IBAction func addItemWhenTap(_ sender: Any) {
        var firstImageNames = libraryImage[0].imageNames
        let random = Int(arc4random())%firstImageNames.count
        let randomImage = firstImageNames[random]
        self.libraryImage[0].imageNames.append(randomImage)
        
        
        let insertItem = IndexPath(row: firstImageNames.count, section: 0)
        self.collectionView?.insertItems(at: [insertItem])
    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        btnAdd.isEnabled = !editing
        
        if let indexPaths = collectionView?.indexPathsForVisibleItems{
            for indexPath in indexPaths{
                if let cell = collectionView?.cellForItem(at: indexPath) as? PhotoCell {
                    cell.editing = editing
                }
            }
        }
    }
    
}
