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
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        cells = [UITableViewCell]()
        game = Main()
        */
        tableView.estimatedRowHeight = 96;
        tableView.rowHeight = UITableViewAutomaticDimension;
    }
    
    override func viewDidAppear(animated: Bool) {
        loadCells()
        tableView.reloadData()
        let lastIndex = NSIndexPath(forRow: 1, inSection: 0)
        self.tableView.scrollToRowAtIndexPath(lastIndex, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)    }
    
    func loadCells() {
        /*let newCells = game.getCurrentBlock(tableView)
        cells.appendContentsOf(newCells)
        updateUI()
        tableView.reloadData()
        */
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    /*
    func updateUI() {
    moneyLabel.text = String(game.money)
    if let year = game.currentChoice?.year {
    yearLabel.text = String(year)
    }
    }
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if !decision {
            let cell = tableView.dequeueReusableCellWithIdentifier("contentCell") as! ContentTableViewCell
            cell.selectionStyle = .None
            decision = true
            tableView.estimatedRowHeight = 96;
            cell.contentTextView.text = "contentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontent"
            
            return cell

        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("decisionCell") as! DecisionTableViewCell
            cell.selectionStyle = .None
            tableView.estimatedRowHeight = 384;
            cell.rightPanel.text = "rightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightrightright"
            cell.leftPanel.text = "leftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleft"
            cell.prompt.text = "promptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptpromptprompt"
            decision = false
            return cell

        }
        //cell.selectionStyle = UITableViewCellSelectionStyle.None
        
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

