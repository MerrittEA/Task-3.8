//
//  ViewController.swift
//  FinalProject CareerFoundry
//
//  Created by PotPie on 7/19/17.
//  Copyright © 2017 PotPie - CareerFoundry. All rights reserved.
//

import UIKit
import CoreData

class RootTableController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {
    
    
    var chores = [ChoreCategory]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.rightBarButtonItem = editButtonItem
        
        
        //automaticallyAdjustsScrollViewInsets = true
        
    }
    
    //load saved data
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        chores = SaveDataModel.sharedInformation.loadChores()
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chores.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChoreTableViewCell
        
        // configure the cell
        let chore = chores[indexPath.row]
        cell.choreCategory = chore
        
        return cell
    }
    // deleting items from tableView in editing mode
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let chore = chores[indexPath.row]
            if SaveDataModel.sharedInformation.deleteChores(chore) {
                chores.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    //ACTIONS
    
    @IBAction func addButtonPressed (_ sender: UIBarButtonItem) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
        viewController.modalPresentationStyle = .popover
        let popover: UIPopoverPresentationController = viewController.popoverPresentationController!
        popover.barButtonItem = sender
        popover.delegate = self
        
        present(viewController, animated: true, completion: nil)
    }
    
    
    // deleting items from tableView
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = chores[sourceIndexPath.row]
        chores.remove(at: sourceIndexPath.row)
        if sourceIndexPath.section == destinationIndexPath.section {
            chores.insert(itemToMove, at: destinationIndexPath.row)
        } else {
            chores.insert(itemToMove, at: destinationIndexPath.row)
        }
        
    }
    
    // editing
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing {
            tableView.setEditing(true, animated: true)
        } else {
            tableView.setEditing(false, animated: true)
        }
    }
    
    // Segue 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let item = chores[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DisplayViewController
                controller.displayChores = item
            }
        }
    }
    
}

