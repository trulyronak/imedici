//
//  MainTableViewController.swift
//  iMedici
//
//  Created by Ronak Shah on 3/12/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    //MARK: - Variables

    var cells: [UITableViewCell]!
    
    var decision = false

    //MARK: - UIViewControler Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cells = [UITableViewCell]()
        game = Main()
        tableView.estimatedRowHeight = 150;
        tableView.rowHeight = UITableViewAutomaticDimension;
    }

    override func viewDidAppear(animated: Bool) {
        loadCells()
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
        if decision {
            tableView.rowHeight = 347
        }
        else{
            tableView.rowHeight = 80
        }
        decision = !decision
        let cell = cells[indexPath.row]
        //cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
    
    // MARK: - IBActions
    
    @IBAction func rightChosen(sender: UIButton) {
        print("You Chosen Right!")
        game.moveRight()
        loadCells()
        sender.removeTarget(nil, action: nil, forControlEvents: .AllEvents)
        
        
    }
    
    @IBAction func leftChosen(sender: UIButton) {
        //includes majors
        print("You Chosen Left!")
        game.moveLeft()
        loadCells()
    }
    
    // MARK: - Other Methods
    
    func loadCells() {
        let newCells = game.getCurrentBlock(self)
        cells.appendContentsOf(newCells)
        updateUI()
        tableView.contentOffset = CGPointMake(0, CGFloat.max)

        tableView.reloadData()
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
