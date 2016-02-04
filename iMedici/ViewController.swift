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
    
    //demo, will remove later
    var currentRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell!
        if currentRow == 0 {
            cell = tableView.dequeueReusableCellWithIdentifier("contentCell")
            tableView.rowHeight = 70
            currentRow++
        }
        
        else {
            cell = tableView.dequeueReusableCellWithIdentifier("decisionCell")
            tableView.rowHeight = 347
            currentRow = 0
        }
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
    
}

