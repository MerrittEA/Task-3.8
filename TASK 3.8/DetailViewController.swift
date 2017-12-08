//
//  DetailViewController.swift
//  FinalProject CareerFoundry
//
//  Created by PotPie on 7/19/17.
//  Copyright © 2017 PotPie - CareerFoundry. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    
    private let starImages = [ "GoldStar.png", "SilverStar.png", "BronzeStar.png" ]
    
    //var testChoreImage = "Dishes@2x.png"
    
    @IBOutlet weak var newChoreName: UITextField!
    //@IBOutlet weak var newImage: UIImageView!
    @IBOutlet weak var starTypeControl: UISegmentedControl!
    @IBOutlet weak var rewardCountControl: UISegmentedControl!
    @IBOutlet weak var lableSaveConfirmed: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ACTION
    @IBAction func saveButtonPressed (_ sender: UIButton) {
        let starType = starImages[starTypeControl.selectedSegmentIndex]
        let rewardCount = rewardCountControl.selectedSegmentIndex
        //let choreImage = testChoreImage
        let choreName = newChoreName.text ?? ""
        if choreName.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            if let addchoreName = SaveDataModel.sharedInformation.addChore(name: choreName,
                                                                           rewardCount: rewardCount,
                                                                           starType: starType) {
                // return to main controller
                print("added chore: \(addchoreName.checkSave)")
                lableSaveConfirmed.text = "Save Confirmed"
                _ = navigationController?.popViewController(animated: true)
            } else {
                print("Did not add new chore")
            }
        }
    }
    
    @IBAction func doneButtonPressed (_ sender: UIButton) {
        func dismissViewController() {
            self.dismiss(animated: true, completion: nil)
        }
        dismissViewController()
    }
}

