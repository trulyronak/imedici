//
//  Reader.swift
//  iMedici
//
//  Created by Ronak Shah on 2/5/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//

import UIKit

class Reader {
    
    //MARK: - Data Reading
    func readData() -> [Choice: [String: Choice]]! {
        var worked = false
        
        var startChoice: String!
        var choices = [String:Choice]()
        
        var file = NSBundle.mainBundle().pathForResource("ChoiceTree", ofType: "txt")! //this is the file. we will write to and read from it
        
        //MARK: - Reading Choice Content
        if let reader = StreamReader(path: file) {
            worked = true
            var currentChoice: Choice!
            
            
            while let line = reader.nextLine() {
                var firstCha =  (line.characters.first)
                print("\(line)")
                if let firstChar = firstCha {
                    switch firstChar {
                    case "#":
                        //comment
                        break
                    case "s" :
                        //case start
                        let nextWord = line.wordAtIndex(1) //ignore = sign
                        if startChoice == nil {
                            startChoice = nextWord
                        }
                        
                        break
                        
                    case "c":
                        //case choice
                        let nextWord = line.wordAtIndex(1)
                        var newChoice = Choice(identity: nextWord!)
                        currentChoice = newChoice
                        choices.updateValue(newChoice, forKey: nextWord!)
                        break
                        
                    case "r":
                        //case rightChoice
                        let nextWord = line.wordAtIndex(1)
                        currentChoice.right = nextWord
                        break
                    case "l":
                        let nextWord = line.wordAtIndex(1)
                        currentChoice.left = nextWord
                        break
                    case "m":
                        //case major
                        let nextWord = line.wordAtIndex(1)
                        currentChoice.major = Int(nextWord!)!
                    default:
                        //empty line
                        break
                    }
                }
            }
            
            //MARK: - Debugging Choice Tree
            
            /*
            for choice in choices.values {
                print("")
                print("Choice \(choice.identifier) ")
                if choice.identifier.containsString("EVENT_") {}
                else {
                    print("Right: \(choice.right) ")
                    print("\(choice.identifier)'s right: \(choices[choice.right!])")
                    print("Left: \(choice.left) ")
                    print("\(choice.identifier)'s left: \(choices[choice.left!])")
                }
                print("")
            }
            */
            defer {
                reader.close()
            }
            
        }
        else {
            worked = false
        }
        
        
        
        //loading content now
        
        var contentTrue = false
        var decisionTrue = false
        var currentChoice: Choice!
        var rightPanel = false
        var leftPanel = false
        
        file = NSBundle.mainBundle().pathForResource("ChoiceContent", ofType: "txt")!
        
        //MARK: - Reading Choice Content
        if let reader = StreamReader(path: file) {
            while let line = reader.nextLine() {
                if line == "choice AA" {
                    let _ = 34
                }
                if line == "" || line.dropFirst()!.containsString("#") {}
                else if leftPanel {
                    print("In Left Panel")
                    if line.wordAtIndex(0) == "picture" {
                        currentChoice.decision.leftImage = UIImage(named: line.wordAtIndex(1)!)
                    }
                    else if line.wordAtIndex(0) == "text" {
                        currentChoice.decision.leftText = line.dropFirst()
                    }
                    else if line.wordAtIndex(0) == "bulletPoints" {
                        var newLine = line.dropFirst()
                        //newLine = String(newLine!.characters.dropFirst())
                        newLine = newLine?.stringByReplacingOccurrencesOfString(" - ", withString: "@ ")
                        
                        let wordArr = newLine!.componentsSeparatedByString("@ ")
                        
                        var bullets = wordArr
                        bullets = Array(bullets.dropFirst())
                        print(bullets)
                        currentChoice.decision.leftBulletPoints = bullets
                    }
                    else if line.wordAtIndex(0) == "cost" {
                        let cost = Double(line.wordAtIndex(1)!)
                        currentChoice.decision.cost = cost
                    }
                    else if line.wordAtIndex(0) == "allowMoney" {
                        let condition = line.wordAtIndex(1)
                        if condition == "true" {
                            currentChoice.decision.allowMoney = true
                        }
                        else {
                            currentChoice.decision.allowMoney = false
                        }
                    }
                    else if line.wordAtIndex(0) == "rep" {
                        currentChoice.decision.leftReputation = Int(line.wordAtIndex(1)!)
                    }
                    else if line.wordAtIndex(0) == "moneyEarned" {
                        let moneyEarned = Double(line.wordAtIndex(1)!)
                        currentChoice.decision.moneyEarned = moneyEarned
                    }
                    else if line == "done" {
                        leftPanel = false
                    }
                }
                else if rightPanel {
                    print("In Right Panel")
                    if line.wordAtIndex(0) == "picture" {
                        currentChoice.decision.rightImage = UIImage(named: line.wordAtIndex(1)!)
                    }
                    else if line.wordAtIndex(0) == "text" {
                        currentChoice.decision.rightText = line.dropFirst()
                    }
                    else if line.wordAtIndex(0) == "bulletPoints" {
                        var newLine = line.dropFirst()
                        //newLine = String(newLine!.characters.dropFirst())
                        newLine = newLine?.stringByReplacingOccurrencesOfString(" - ", withString: "@ ")
                        
                        let wordArr = newLine!.componentsSeparatedByString("@ ")
                        
                        var bullets = wordArr
                        
                        bullets = Array(bullets.dropFirst())
                        currentChoice.decision.rightBulletPoints = bullets
                    }
                    else if line.wordAtIndex(0) == "cost" {
                        let cost = Double(line.wordAtIndex(1)!)
                        currentChoice.decision.cost = cost
                    }
                    else if line.wordAtIndex(0) == "allowMoney" {
                        let condition = line.wordAtIndex(1)
                        if condition == "true" {
                            currentChoice.decision.allowMoney = true
                        }
                        else {
                            currentChoice.decision.allowMoney = false
                        }
                    }
                    else if line.wordAtIndex(0) == "moneyEarned" {
                        let moneyEarned = Double(line.wordAtIndex(1)!)
                        currentChoice.decision.moneyEarned = moneyEarned
                    }
                    else if line == "done" {
                        rightPanel = false
                    }
                }
                else if decisionTrue {
                    print("In Decision True")
                    let indicator = line
                    
                    if line.wordAtIndex(0) == "prompt" {
                        let prompt = line.dropFirst()
                        currentChoice.decision.prompt = prompt
                    }
                    else if indicator == "leftPanel" {
                        leftPanel = true
                    }
                    else if indicator == "rightPanel" {
                        rightPanel = true
                    }
                    else if (line.wordAtIndex(0) == "choice") {
                        currentChoice = choices[line.wordAtIndex(1)!]
                        print("Current Choice: \(line.wordAtIndex(1))")
                        print("")
                        decisionTrue = false
                    }
                }
                else {
                    if (line.wordAtIndex(0) == "choice") {
                        currentChoice = choices[line.wordAtIndex(1)!]
                        print("Current Choice: \(line.wordAtIndex(1))")
                        print("")
                        currentChoice.checkIfSingle()
                    }
                    else if (line.wordAtIndex(0) == "year") {
                        currentChoice.year = Int(line.wordAtIndex(1)!)!
                    }
                    else if (line.wordAtIndex(0) == "content") {
                        currentChoice.content = Content(text: line.dropFirst()!)
                    }
                    else if (line == "decision") {
                        decisionTrue = true
                        currentChoice.decision = Decision()
                        
                    }
                }
                
            }
            
            
            defer {
                reader.close()
            }
            //MARK: Debugging Choice Content
            
            /*
            for choice in choices.values {
                
                
                print("")
                print("Choice \(choice.identifier)")
                print("Choice Content")
                print(choice.content.text)
                if choice.identifier.containsString("X"){}
                if choice.identifier.containsString("EVENT_") {}
                else {
                    print("Choice Decision:")
                    print(choice.decision.prompt)
                    if choice.left!.containsString("none") {}
                    else {
                        print("Left Panel")
                        print(choice.decision.leftText)
                        print(choice.decision.leftBulletPoints)
                        print(choice.decision.leftImage)
                        print(choice.decision.cost)
                    }
                    print("Right Panel")
                    print(choice.decision.rightText)
                    print(choice.decision.rightBulletPoints)
                    print(choice.decision.rightImage)
                    print(choice.decision.moneyEarned)
                    print("")
                    
                }
                
                
            }
            */
        }
        else {
            worked = false
        }
        if worked {
            //MARK: - Returning Choices
            var toReturn: [Choice: [String: Choice]] = [Choice: [String: Choice]]()
            toReturn.updateValue(choices, forKey: choices[startChoice]!)
            
            
            return toReturn
        }
        else {
            
            //file not found
            //end of function
            return nil
        }
    }
    
    
}
