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
    var content: Content!
    var major: Int //1 or 2
    var year: Int
    //tree
    var left: String?
    var right: String?
    
    var singleChoice = false
    init(identity: String) {
        self.identifier = identity
        isActive = false
        decision = nil
        content = nil
        major = 0
        year = 1420
    }
    
    ///Not What You Think
    func checkIfSingle() {
        if left == "none" {
            singleChoice = true
        }
    }
    //data management protocols
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(isActive, forKey: "isActive")
        coder.encodeObject(decision, forKey: "decision")
        coder.encodeObject(identifier, forKey: "identifier")
        coder.encodeObject(content, forKey: "content")
        coder.encodeObject(major, forKey: "major")
        coder.encodeObject(year, forKey: "year")
        coder.encodeObject(left, forKey: "left")
        coder.encodeObject(right, forKey: "right")
    }
    
    required init(coder: NSCoder) {
        self.isActive = coder.decodeObjectForKey("isActive") as! Bool
        self.decision = coder.decodeObjectForKey("decision") as! Decision
        self.identifier = coder.decodeObjectForKey("identifier") as! String
        self.content = coder.decodeObjectForKey("content") as! Content
        self.major = coder.decodeObjectForKey("major") as! Int
        self.year = coder.decodeObjectForKey("year") as! Int
        self.left = coder.decodeObjectForKey("left") as? String
        self.right = coder.decodeObjectForKey("right") as? String
    }


    
}