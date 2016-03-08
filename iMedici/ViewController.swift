//
//  ViewController.swift
//  iMedici
//
//  Created by Ronak Shah on 2/1/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
    }
    
    override func viewDidAppear(animated: Bool) {
        loadCells()
        tableView.reloadData()
    }
    
    func loadCells() {
        let newCells = game.getCurrentBlock(tableView)
        cells.appendContentsOf(newCells)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
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
        tableView.reloadData()
    }
    
    @IBAction func leftChosen(sender: UIButton) {
        print("You Chosen Left!")
        game.moveLeft()
        loadCells()
        tableView.reloadData()
    }
}

