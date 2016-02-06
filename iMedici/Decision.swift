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
    var leftImage: UIImage!
    var leftText: String!
    var leftBulletPoints: [String]!
    
    //right panel
    var rightImage: UIImage!
    var rightText: String!
    var rightBulletPoints: [String]!
    
    override init() {
        //left
        leftImage = nil
        leftText = nil
        leftBulletPoints = nil
        //right
        rightImage = nil
        rightText = nil
        rightBulletPoints = nil
        
        //general
        prompt = nil
    }
    
    //data management protocols
    func encodeWithCoder(coder: NSCoder) {
        //prompt objects
        coder.encodeObject(prompt, forKey: "prompt")

        //left panel objects
        coder.encodeObject(leftImage, forKey: "leftImage")
        coder.encodeObject(leftText, forKey: "leftText")
        coder.encodeObject(leftBulletPoints, forKey: "leftBulletPoints")
        
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