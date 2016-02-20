//
//  Content.swift
//  iMedici
//
//  Created by Ronak Shah on 2/11/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//

import Foundation

class Content: NSObject, NSCoding {
    var text: String
    
    init(text: String) {
        self.text = text
    }
    
    //data management protocols
    func encodeWithCoder(coder: NSCoder) {
 
        coder.encodeObject(text, forKey: "text")
        
        
    }
    
    required init(coder: NSCoder) {
        self.text = coder.decodeObjectForKey("text") as! String
        
        super.init()
    }

}