//
//  MainTableViewController.swift
//  iMedici
//
//  Created by Ronak Shah on 3/12/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//

/*
tableView.estimatedRowHeight = 150;
tableView.rowHeight = UITableViewAutomaticDimension;
*/

import UIKit

class MainTableViewController: UITableViewController {
    
    //MARK: - Variables
    
    var bools: [String:Bool]!
    var cells: [UITableViewCell]!
    
    
    //MARK: - UIViewControler Methods
    
    override func viewDidLoad() {
        bools = [String:Bool]()
        super.viewDidLoad()
        cells = [UITableViewCell]()
        game = Main()
        bools.updateValue(false, forKey: "decision")
        bools.updateValue(true, forKey: "firstRun")
    }
    
    override func viewDidAppear(animated: Bool) {
        if bools["firstRun"] == true {
            loadCells()
            bools.updateValue(false, forKey: "firstRun")
        }
        
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View Code
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = cells[indexPath.row]
        
        if let _ = cell as? ContentTableViewCell{
            tableView.rowHeight = 160
            
        }
        else{
            if let decisionCell = cell as? DecisionTableViewCell {
                if decisionCell.identifier == game.story.startChoice.identifier {
                    tableView.rowHeight = 380
                    
                }
            }
            else {
                tableView.rowHeight = 380
            }
            
        }
        //cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
    
    override func tableView(tableView: UITableView,
        heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            if indexPath.row == 0 {
                return 380
            }
            else if indexPath.row % 2 == 1 { //if its even
                return 450
            }
            else {
                return 170
            }
    }
    
    // MARK: - Other Methods
    
    func loadCells() {
        let newCells = game.getCurrentBlock(self)
        cells.appendContentsOf(newCells)
        updateUI()
        tableView.contentOffset = CGPointMake(0, CGFloat.max)
        
        tableView.reloadData()
        print(cells)
    }
    
    func updateUI() {
        self.navigationItem.leftBarButtonItem?.title = String(game.money)
        //moneyLabel.text = String(game.money)
        if let year = game.currentChoice?.year {
            //yearLabel.text = String(year)
            self.navigationItem.rightBarButtonItem?.title = String(year)
        }
    }
    
    /*
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
