//
//  Data.swift
//  Demo
//
//  Created by TPPFIT iCloud on 7/14/17.
//  Copyright © 2017 TPPFIT iCloud. All rights reserved.
//

import Foundation

struct photoCategory {
    var categoryName:String
    var categoryIconName:String
    var imageNames:[String]
}
class PhotoData{
    public class func convertData() -> [photoCategory]{
        let originalData = PhotoData.getData()
        var categoryData = [photoCategory]()
        for (categoryTitle,item) in originalData{
            if let dict = item as? [String : Any]{
                let categoryImageName = dict["categoryImage"]
                if let imageNames = dict["imageNames"]{
                    let newcategory = photoCategory(categoryName: categoryTitle, categoryIconName: categoryImageName as! String, imageNames: imageNames as! [String])
                    categoryData.append(newcategory)
                }
            }
        }
        return categoryData
    }
    public class func getData() -> [String : Any]{
        return ["Family":["categoryImage":"family","imageNames":generateImageName(startName:"f",numberOfPhoto:9)],"Foods":["categoryImage":"foods","imageNames":generateImageName(startName:"fo",numberOfPhoto:8)],"Travel":["categoryImage":"travel","imageNames":generateImageName(startName:"t",numberOfPhoto:8)],"Nature":["categoryImage":"nature","imageNames":generateImageName(startName:"n",numberOfPhoto:9)]]
    }
    private class func generateImageName(startName:String,numberOfPhoto:Int) -> [String]{
        var tempArray = [String]()
        for i in 1...numberOfPhoto{
            tempArray.append("\(startName)\(i)")
        }
        return tempArray
    }
}
