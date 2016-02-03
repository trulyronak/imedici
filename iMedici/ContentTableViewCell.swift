//
//  ContentTableViewCell.swift
//  iMedici
//
//  Created by Ronak Shah on 2/2/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//

import UIKit

class ContentTableViewCell: UITableViewCell {

    @IBOutlet var contentTextView: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        //super.setSelected(selected, animated: animated)
        //nothing for now
        // Configure the view for the selected state
    }

}
