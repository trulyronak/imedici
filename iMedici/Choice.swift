//
//  Choice.swift
//  iMedici
//
//  Created by Ronak Shah on 2/5/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//

import Foundation

class Choice: NSObject, NSCoding {
    var isActive:Bool
    
    
    override init() {
        isActive = false
    }
    
    //data management protocols
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(isActive, forKey: "isActive")

    }
    
    required init(coder: NSCoder) {
        self.isActive = coder.decodeObjectForKey("isActive") as! Bool
        
        super.init()
    }

    
}