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
    
    
    @IBOutlet weak var choreNameDisplay: UILabel!
    @IBOutlet weak var choreRewardDisplay: UILabel!
    @IBOutlet weak var starImageDisplay: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        reFreshUI()
        
        //let fileManager = FileManager.default
        //var databaseUrl: URL? = nil
        
        //do {
            //let baseUrl = try
                //fileManager.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
            //databaseUrl = baseUrl.appendingPathComponent("swifty.sqlite")
        //}catch {
            //print(error)
        //}

        //if let databaseUrl = databaseUrl {
            //let fmdb = FMDatabase(path: databaseUrl.absoluteString)
            //fmdb.open()
        
        //let selectSql = "select * from ChoreTable"
            //if let fmbdResult = fmdb.executeQuery(selectSql, withParameterDictionary: nil) {
               //chores.removeAll()
            //while (fmbdResult.next()) {
                //let rowId = fmbdResult.int(forColumn: SaveDataModel.idFieldName)
                //let rewardCount = fmbdResult.string(forColumn: ChoreCategory.PropertyNames.rewardCountField)
                //let choreName = fmbdResult.string(forColumn: ChoreCategory.PropertyNames.choreNameField) ?? ""
                //let starType = fmbdResult.string(forColumn: ChoreCategory.PropertyNames.starTypeField) ?? ""
                
                //choreNameDisplay.text = choreName
                //choreRewardDisplay.text = rewardCount
                //starImageDisplay.image = UIImage(named: starType)
                //reFreshUI()
                //}
            //}
            //fmdb.close()
        //}
    }
        
    
        //choresForDisplay = SaveDataModel.sharedInformation.loadChores()
        //let name = ChoreCategory.PropertyNames.choreNameField
        //let reward = ChoreCategory.PropertyNames.rewardCountField
        //let star = ChoreCategory.PropertyNames.starTypeField
        
        //choreNameDisplay.text = ""
        //choreRewardDisplay.text = reward
        //starImageDisplay.image = UIImage(named: star)
            //choresForDisplay.choreName = choreNameDisplay.text
            //choresForDisplay.rewardCount = choreRewardDisplay.text
            //choresForDisplay.starType = starImageDisplay.image
        //}
    
        
        //if let choresItem = self.displayChores {
            //choreNameDisplay.text = choresItem.choreName
            //choreRewardDisplay.text = choresItem.rewardCount
            //starImageDisplay.image = UIImage(named: choresItem.starType!)
        //}
    //}



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
        
        let selectSql = "select * from ChoreTable"
        if let fmbdResult = fmdb.executeQuery(selectSql, withParameterDictionary: nil) {
            chores.removeAll()
            while (fmbdResult.next()) {
                choreNameDisplay.text =  fmbdResult.string(forColumn: ChoreCategory.PropertyNames.choreNameField) ?? ""
                choreRewardDisplay.text = fmbdResult.string(forColumn: ChoreCategory.PropertyNames.rewardCountField)
                starImageDisplay.image =  UIImage(named: fmbdResult.string(forColumn: ChoreCategory.PropertyNames.starTypeField) ?? "")
            }
        }
            fmdb.close()
        }
    }


}
