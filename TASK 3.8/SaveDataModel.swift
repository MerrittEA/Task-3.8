//
//  SaveDataModel.swift
//  FinalProject CareerFoundry
//
//  Created by PotPie on 7/19/17.
//  Copyright © 2017 PotPie - CareerFoundry. All rights reserved.
//

import Foundation
import UIKit


class SaveDataModel {
    static let sharedInformation = SaveDataModel()
    
    struct SQLstatements {
        static let selectallChores = "select * from ChoreTable"
        static let createChoreTable = "create table if not exists ChoreTable (ID Integer Primary Key AutoIncrement, Name Text, RewardCount Integer, StarType Text);"
        static let insertChoreSQL = "insert into ChoreTable (Name, RewardCount, StarType) values "
        static let deleteChoreSQL = "delete from ChoreTable where ID = ?"
    }
    
    //static let idFieldName = "ID"
    
    private let fileManager = FileManager.default
    private let databaseFileName = "swifty.sqlite"
    private var databaseUrl: URL? = nil
    private var database: FMDatabase? = nil
    
    var chores = [ChoreCategory]()
    
    private init() {
        databaseUrl = getDatabaseURL()
        database = FMDatabase(path: databaseUrl?.absoluteString)
        database?.open()
        
        
        do {
            try database?.executeUpdate(SQLstatements.createChoreTable, values: nil)
            // try database?.executeUpdate(SQLstatements.insertChoreSQL, values: nil)
        } catch {
            print("database not created")
        }
    }
    
    //Functions for easy coding
    
    //loading the chores added
    func loadChores() -> [ChoreCategory] {
        if let database = database {
            database.open()
            
            if let fmdbResult = database.executeQuery(SQLstatements.selectallChores, withParameterDictionary: nil) {
                chores.removeAll()
                while (fmdbResult.next()) {
                    let rowID = fmdbResult.int(forColumn: "ID")
                    let rewardCount = fmdbResult.int(forColumn: ChoreCategory.PropertyNames.rewardCountField)
                    let name = fmdbResult.string(forColumn: ChoreCategory.PropertyNames.choreNameField) ?? ""
                    //let imageName = fmdbResult.string(forColumn: ChoreCategory.PropertyNames.imageNameField) ?? ""
                    let starType = fmdbResult.string(forColumn: ChoreCategory.PropertyNames.starTypeField) ?? ""
                    
                    let chore = ChoreCategory(choreName: name, rewardCount: Int(rewardCount), starType: starType)
                    chore.rowID = Int(rowID) // set correct row id
                    
                    chores.append(chore)
                    print("Record ID: \(rowID) Name: \(name) RewardCount: \(rewardCount) StarType: \(starType)")
                }
            }
            database.close()
        }
        return chores
    }
    
    // deleting chores from database
    
    func deleteChores(_ chore: ChoreCategory) -> Bool {
        if let database = database,
            let choreID = chore.rowID {
            database.open()
            database.executeUpdate(SQLstatements.deleteChoreSQL, withArgumentsIn: [choreID])
            database.close()
            return true
        }
        return false
    }
    
    // adding a chore
    
    func addChore(name: String, rewardCount: Int, starType: String) -> ChoreCategory? {
        let newChore = ChoreCategory(choreName: name, rewardCount: rewardCount, starType: starType)
        
        if let database = database {
            database.open()
            
            let sqlStatment = SQLstatements.createChoreTable
            let insertStatement = "\(SQLstatements.insertChoreSQL)('\(name)',\(rewardCount),'\(starType)');"
            do {
                try database.executeUpdate(sqlStatment, values: nil)
                try database.executeUpdate(insertStatement, values: nil)
                chores.insert(newChore, at: 0)
                print("added new chore")
                database.close()
                return newChore
            } catch {
                print(error.localizedDescription)
                database.close()
            }
        }
        return nil
    }
    
    //geting URL
    private func getDatabaseURL() -> URL? {
        do {
            let baseUrl = try
                fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let url = baseUrl.appendingPathComponent(databaseFileName)
            return url
        } catch {
            print("database not found")
        }
        return nil
    }
}
