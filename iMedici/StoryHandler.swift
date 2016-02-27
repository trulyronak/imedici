//
//  StoryHandler.swift
//  iMedici
//
//  Created by Ronak Shah on 2/5/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//

import Foundation

class StoryHandler {
    var choices: [String: Choice]!
    var startChoice: Choice!
    
    func readLevel(){
        let array = Reader().readData()
        for (key, value) in array {
            self.startChoice = key
            self.choices = value
        }
        let range = [0,1,2,3,4,5]
        
        for _ in range {
            print("")
        }
        
        print("Choices:")
        print(self.choices)
        print("Starting Choice: \(startChoice.identifier)")
        for _ in range {
            print("")
        }
    }
}