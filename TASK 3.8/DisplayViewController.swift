//
//  DisplayViewController.swift
//  TASK 3.8
//
//  Created by PotPie on 7/28/17.
//  Copyright © 2017 PotPie - CareerFoundry. All rights reserved.
//

import UIKit

class DisplayViewController: UIViewController {
    
    var choresForDisplay = [ChoreCategory]()
    
    @IBOutlet weak var choreNameDisplay: UILabel!
    @IBOutlet weak var choreRewardDisplay: UISegmentedControl!
    @IBOutlet weak var starImageDisplay: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let choresForDisplay = SaveDataModel.sharedInformation.loadChores() {
            choreNameDisplay.text = choresForDisplay.name
            
        }
       
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
