//
//  MainViewController.swift
//  iMedici
//
//  Created by Ronak Shah on 3/9/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var moneyLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    var cells: [UITableViewCell]!
    
    //demo, will remove later
    var decision = false
    
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
    
    func loadCells() {
        let newCells = game.getCurrentBlock(tableView)
        cells.appendContentsOf(newCells)
        updateUI()
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func updateUI() {
        moneyLabel.text = String(game.money)
        if let year = game.currentChoice?.year {
            yearLabel.text = String(year)
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
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
}

