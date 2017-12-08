//
//  ChoreTableViewCell.swift
//  FinalProject CareerFoundry
//
//  Created by PotPie on 7/19/17.
//  Copyright © 2017 PotPie - CareerFoundry. All rights reserved.
//

import UIKit
import CoreData

class ChoreTableViewCell: UITableViewCell {
    
    //@IBOutlet private weak var choreImage: UIImageView!
    @IBOutlet private weak var choreLabel: UILabel!
    @IBOutlet private weak var rewardCountLabel: UILabel!
    @IBOutlet private weak var starImage: UIImageView!
    
    var choreCategory: ChoreCategory? {
        didSet {
            loadUI()
        }
    }
    
    // load the new info
    private func loadUI() {
        if let category = self.choreCategory {
            //let imageName = category.imageName ?? ""
            let starType = category.starType ?? ""
            rewardCountLabel.text = String(category.rewardCount)
            //choreImage.image = UIImage(named: imageName)
            choreLabel.text = category.choreName
            starImage.image = UIImage(named: starType)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
