//
//  SingleChoiceDecisionTableViewCell.swift
//  iMedici
//
//  Created by Ronak Shah on 3/8/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//

import UIKit

class SingleChoiceDecisionTableViewCell: UITableViewCell {
    @IBOutlet var prompt: UITextView!
    @IBOutlet var rightPanel: UITextView!
    var identifier:String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
