//
//  Decision.swift
//  iMedici
//
//  Created by Ronak Shah on 2/5/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//

import UIKit

class Decision: NSObject, NSCoding{
    var prompt: String!
    
    //left panel
    var leftImage: UIImage?
    var leftText: String?
    var leftBulletPoints: [String]?
    var cost: Double?
    var leftReputation: Int!

    //right panel
    var rightImage: UIImage?
    var rightText: String?
    var rightBulletPoints: [String]?
    var moneyEarned: Double?
    var allowMoney: Bool?

    
    override init() {
        //left
        leftImage = nil
        leftText = nil
        leftBulletPoints = nil
        cost = nil
        leftReputation = 0
        //right
        rightImage = nil
        rightText = nil
        rightBulletPoints = nil
        moneyEarned = nil
        allowMoney = false
        //general
        prompt = nil
        
        
    }
    
    func leftImageTrue() -> Bool {
        if let _ = leftImage {
            return true
        }
        return false
    }
    
    func rightImageTrue() -> Bool {
        if let _ = rightImage {
            return true
        }
        return false
    }
    
    func leftTextTrue() -> Bool {
        if let _ = leftText {
            return true
        }
        return false
    }
    
    func rightTextTrue() -> Bool {
        if let _ = rightText {
            return true
        }
        return false
    }
    
    func leftBulletPointsTrue() -> Bool {
        if let _ = leftBulletPoints {
            return true
        }
        return false
    }
    
    func rightBulletPointsTrue() -> Bool {
        if let _ = rightBulletPoints {
            return true
        }
        return false
    }
    
    func leftReputationTrue() -> Bool {
        if let _ = leftReputation {
            return true
        }
        return false
    }
    
    
    //data management protocols
    func encodeWithCoder(coder: NSCoder) {
        //prompt objects
        coder.encodeObject(prompt, forKey: "prompt")

        //left panel objects
        coder.encodeObject(leftImage, forKey: "leftImage")
        coder.encodeObject(leftText, forKey: "leftText")
        coder.encodeObject(leftBulletPoints, forKey: "leftBulletPoints")
        coder.encodeObject(leftReputation, forKey: "reputation")

        //right panel objects
        coder.encodeObject(rightImage, forKey: "rightImage")
        coder.encodeObject(rightText, forKey: "rightText")
        coder.encodeObject(rightBulletPoints, forKey: "rightBulletPoints")

    }
    
    required init(coder: NSCoder) {
        self.prompt = coder.decodeObjectForKey("prompt") as! String
        
        super.init()
    }

}