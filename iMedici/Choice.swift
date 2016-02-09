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
    var decision: Decision!
    var identifier: String
    
    //tree
    var left: Choice?
    var right: Choice?
    
    init(identity: String) {
        self.identifier = identity
        isActive = false
        decision = nil
    }
    
    //data management protocols
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(isActive, forKey: "isActive")
        coder.encodeObject(decision, forKey: "decision")
        coder.encodeObject(identifier, forKey: "identifier")
    }
    
    required init(coder: NSCoder) {
        self.isActive = coder.decodeObjectForKey("isActive") as! Bool
        self.decision = coder.decodeObjectForKey("decision") as! Decision
        self.identifier = coder.decodeObjectForKey("identifier") as! String
    }

    
}