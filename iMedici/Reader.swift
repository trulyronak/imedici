//
//  Reader.swift
//  iMedici
//
//  Created by Ronak Shah on 2/5/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//

import Foundation

class Reader {
    func readData() {
        let file = NSBundle.mainBundle().pathForResource("ChoiceTree", ofType: "txt")! //this is the file. we will write to and read from it
        
        if let reader = StreamReader(path: file) {
            var startChoice: String!
            var choices = [Choice]()
            var currentChoice: Choice!
            
            while let line = reader.nextLine() {
                var firstCha =  (line.characters.first)
                
                if let firstChar = firstCha {
                    switch firstChar {
                    case "s" :
                        //case start
                        let nextWord = line.wordAtIndex(1)
                        startChoice = nextWord
                        break
                        
                    case "c":
                        //case choice
                        let nextWord = line.wordAtIndex(1)
                        var newChoice = Choice(identity: nextWord!)
                        currentChoice = newChoice
                        choices.append(newChoice)
                        break
                        
                    case "r":
                        //case rightChoice
                        let nextWord = line.wordAtIndex(1)
                        var newChoice = Choice(identity: nextWord!)
                        currentChoice.right = newChoice
                        break
                    case "l":
                        let nextWord = line.wordAtIndex(1)
                        var newChoice = Choice(identity: nextWord!)
                        currentChoice.left = newChoice
                        break
                    default:
                        //empty line
                        break
                    }
                }
            }
            
            
            defer {
                reader.close()
            }
            
            //loading content now
            
            let file = NSBundle.mainBundle().pathForResource("ChoiceContent", ofType: "txt")! //this is the file. we will write to and read from it
            
            if let reader = StreamReader(path: file) {
                var currentChoice: Choice!
                
                while let line = reader.nextLine() {
                    if line.wordAtIndex(0) == "choice" {
                        
                    }
                }
                defer {
                    reader.close()
                }

            
        }
        else {
            //file not found
            
        }
    }
    //end of function
}
