//
//  DisplayViewController.swift
//  TASK 3.8
//
//  Created by PotPie on 7/28/17.
//  Copyright © 2017 PotPie - CareerFoundry. All rights reserved.
//

import UIKit

class DisplayViewController: UIViewController {
    
    var displayChores:  ChoreCategory?
    var chores = [ChoreCategory]()
    
    var choreID = Int()
    @IBOutlet weak var choreNameDisplay: UILabel!
    @IBOutlet weak var choreRewardDisplay: UILabel!
    @IBOutlet weak var starImageDisplay: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        reFreshUI()
    }



        // Do any additional setup after loading the view.

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reFreshUI() {
        
        let fileManager = FileManager.default
        var databaseUrl: URL? = nil
        
        do {
            let baseUrl = try
                fileManager.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
            databaseUrl = baseUrl.appendingPathComponent("swifty.sqlite")
        }catch {
            print(error)
        }
        
        if let databaseUrl = databaseUrl {
        let fmdb = FMDatabase(path: databaseUrl.absoluteString)
        fmdb.open()
        
        
            let selectSql = "select * from ChoreTable WHERE ID = :id" //referencing the correct row ID
            if let fmdbResult = fmdb.executeQuery(selectSql, withParameterDictionary: ["id" : displayChores?.rowID!]) {
            chores.removeAll()
            while (fmdbResult.next()) {
                //let rowID = fmdbResult.int(forColumn: "ID")
                let choreName =  fmdbResult.string(forColumn: ChoreCategory.PropertyNames.choreNameField) ?? ""
                let choreReward = fmdbResult.string(forColumn: ChoreCategory.PropertyNames.rewardCountField)
                let starImage =  UIImage(named: fmdbResult.string(forColumn: ChoreCategory.PropertyNames.starTypeField) ?? "")
                
                choreNameDisplay.text = choreName
                choreRewardDisplay.text = choreReward
                starImageDisplay.image = starImage
            }
        }
            fmdb.close()
        }
    }


}
