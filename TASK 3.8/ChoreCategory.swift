//
//  ChoreCategory.swift
//  FinalProject CareerFoundry
//
//  Created by PotPie on 7/19/17.
//  Copyright © 2017 PotPie - CareerFoundry. All rights reserved.
//

import UIKit

class ChoreCategory {
    
    struct PropertyNames {
        static let choreNameField = "name"
        //static let imageNameField = "imageName"
        static let rewardCountField = "rewardCount"
        static let starTypeField = "starType"
        static let rowID = "ID"
    }
    
    var rowID: Int?
    var choreName: String?
    //var imageName: String?
    var rewardCount: Int
    var starType: String?
    
    init(choreName: String, rewardCount: Int, starType: String) {
        self.choreName = choreName
        //self.imageName = imageName
        self.rewardCount = rewardCount
        self.starType = starType
    }
    
    var checkSave: String {
        return "\(String(describing: choreName)) with startype \(String(describing: starType)) and points of \(rewardCount))"
    }
}
