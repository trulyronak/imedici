//
//  DecisionTableViewCell.swift
//  iMedici
//
//  Created by Ronak Shah on 2/2/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//

import UIKit

class DecisionTableViewCell: UITableViewCell {

    @IBOutlet var questionView: UITextView!
    @IBOutlet var leftDecision: UITextView!
    @IBOutlet var rightDecision: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        //super.setSelected(selected, animated: animated)
        //nothing for now
        // Configure the view for the selected state
    }

    @IBAction func makeDecisionTapped(sender: UIButton) {
    }
}
