//
//  DecisionTableViewCell.swift
//  iMedici
//
//  Created by Ronak Shah on 2/2/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//

import UIKit

class DecisionTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet var prompt: UITextView!
    @IBOutlet var leftPanel: UITextView!
    @IBOutlet var rightPanel: UITextView!
    
    var identifier: String!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        leftPanel.tag = 0
        rightPanel.tag = 1
    }

    override func setSelected(selected: Bool, animated: Bool) {
        //super.setSelected(selected, animated: animated)
        //nothing for now
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        prompt.text = ""
        leftPanel.text = ""
        rightPanel.text = ""
    }


    @IBAction func rightChosen(sender: UIButton) {
        print("You Chosen Right!")
        rightPanel.backgroundColor = UIColor.blueColor()
        sender.backgroundColor = UIColor.blueColor()
    }
    
    @IBAction func leftChosen(sender: UIButton) {
        print("You Chosen Left!")
        leftPanel.backgroundColor = UIColor.blueColor()
        sender.backgroundColor = UIColor.blueColor()
    }
}
