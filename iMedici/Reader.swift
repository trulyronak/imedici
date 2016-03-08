//
//  Reader.swift
//  iMedici
//
//  Created by Ronak Shah on 2/5/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//

import UIKit

class Reader {
    func readData() -> [Choice: [String: Choice]]! {
        var worked = false
        
        var startChoice: String!
        var choices = [String:Choice]()
        
        var file = NSBundle.mainBundle().pathForResource("ChoiceTree", ofType: "txt")! //this is the file. we will write to and read from it
        
        if let reader = StreamReader(path: file) {
            worked = true
            var currentChoice: Choice!
            
            
            while let line = reader.nextLine() {
                var firstCha =  (line.characters.first)
                
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
        
        if let reader = StreamReader(path: file) {
            while let line = reader.nextLine() {
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
                else if contentTrue {
                    print("In Content True")
                    currentChoice.content = Content(text: line)
                    contentTrue = false
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
                    }
                    else if (line.wordAtIndex(0) == "year") {
                        currentChoice.year = Int(line.wordAtIndex(1)!)!
                    }
                    else if (line.wordAtIndex(0) == "content") {
                        print("In Content")
                        contentTrue = true
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
        }
        else {
            worked = false
        }
        /*
        let file = NSBundle.mainBundle().pathForResource("ChoiceContent", ofType: "txt")! //this is the file. we will write to and read from it
        
        if let reader = StreamReader(path: file) {
        var currentChoice: Choice!
        
        
        //bools
        var choiceTrue = false
        var decisionTrue = false
        var contentTrue = false
        
        //decision bools
        var promptTrue = false
        var leftPanelTrue = false
        var rightPanelTrue = false
        var pictureTrue = false
        var textTrue = false
        var costTrue = false
        var allowMoneyTrue = false
        var moneyEarnedTrue = false
        var bulletPointsTrue = false
        
        
        func negateAllDecision() {
        promptTrue = false
        
        pictureTrue = false
        textTrue = false
        costTrue = false
        allowMoneyTrue = false
        moneyEarnedTrue = false
        bulletPointsTrue = false
        }
        var decision: Decision!
        var content: Content!
        
        var outsideBypass = -1
        var bypass = false
        while let line = reader.nextLine() {
        var place: Int!
        
        if !bypass {
        let options = ["choice", "content", "decision", "prompt", "leftPanel", "rightPanel", "response1", "response2"]
        let inner = ["picture", "text", "bulletPoints", "cost" , "allowMoney", "moneyEarned", "cost", "major"]
        
        for opt in options {
        if line == opt {
        place = options.indexOf(opt)
        }
        }
        }
        else {
        place = outsideBypass
        }
        switch(place) {
        case 0:
        //case choice
        currentChoice = choices[line.wordAtIndex(1)!] //second word
        break
        case 1, 2:
        //case content, decision
        outsideBypass = true
        currentChoice.content = content
        currentChoice.decision = decision
        
        bypass = true
        break
        case 3:
        //case prompt
        break
        case 4:
        //case leftPanel
        break
        case 5:
        //case rightPanel
        break
        case 6:
        //case response1
        break
        case 7:
        //case response2
        break
        default:
        break
        }
        }
        
        */
        /*
        while let line = reader.nextLine() {
        print(line)
        if line.wordAtIndex(0) == "#" {
        //do nothing, its just a comment
        }
        
        else if line.wordAtIndex(0) == "choice" {
        //choice
        currentChoice = choices[line.wordAtIndex(1)!]
        choiceTrue = true
        }
        
        else {
        if line.wordAtIndex(0) == "content" {
        contentTrue = true
        choiceTrue = false
        decisionTrue = false
        if decision != nil {
        currentChoice.decision = decision
        }
        }
        else if line.wordAtIndex(0) == "decision" {
        decisionTrue = true
        contentTrue = false
        choiceTrue = false
        decision = Decision()
        }
        
        else if contentTrue {
        var textRead = line
        var newContent = Content(text: textRead)
        currentChoice.content = newContent
        }
        else if decisionTrue {
        if line.wordAtIndex(0) == "prompt"{
        negateAllDecision()
        promptTrue = true
        }
        else if line.wordAtIndex(0) == "leftPanel" || line.wordAtIndex(0) == "panel1"{
        negateAllDecision()
        leftPanelTrue = true
        }
        else if line.wordAtIndex(0) == "picture" {
        negateAllDecision()
        pictureTrue = true
        }
        else if line.wordAtIndex(0) == "text" {
        
        negateAllDecision()
        textTrue = true
        }
        else if line.wordAtIndex(0) == "bulletPoints" {
        negateAllDecision()
        bulletPointsTrue = true
        decisionTrue = false // to avoid too long loading
        }
        else if line.wordAtIndex(0) == "cost" {
        negateAllDecision()
        costTrue = true
        }
        else if line.wordAtIndex(0) == "rightPanel" || line.wordAtIndex(0) == "panel2" {
        negateAllDecision()
        rightPanelTrue = true
        leftPanelTrue = false
        }
        else if line.wordAtIndex(0) == "allowMoney" {
        negateAllDecision()
        allowMoneyTrue = true
        }
        
        //now for the actual content part
        else if promptTrue {
        decision.prompt = line
        }
        else if leftPanelTrue && textTrue {
        decision.leftText = line
        }
        else if rightPanelTrue && textTrue {
        decision.rightText = line
        }
        else if pictureTrue {
        if rightPanelTrue {
        decision.rightImage = UIImage(named: line)
        }
        else if leftPanelTrue {
        decision.leftImage = UIImage(named: line)
        }
        }
        else if costTrue {
        decision.cost = Double(line)
        }
        else if allowMoneyTrue {
        if line == "true" {
        decision.allowMoney = true
        }
        else {
        decision.allowMoney = false
        }
        }
        else if moneyEarnedTrue {
        decision.moneyEarned = Double(line)
        }
        }
        else if bulletPointsTrue {
        if line.wordAtIndex(0) == "-" && leftPanelTrue {
        var bullet = line.substringWithRange(Range<String.Index>(start: line.startIndex.advancedBy(1), end: line.endIndex)) //"llo, playgroun"
        decision.leftBulletPoints.append(bullet)
        }
        else if line.wordAtIndex(0) == "-" && rightPanelTrue {
        var bullet = line.substringWithRange(Range<String.Index>(start: line.startIndex.advancedBy(1), end: line.endIndex)) //"llo, playgroun"
        decision.rightBulletPoints.append(bullet)
        }
        else if line.wordAtIndex(0) == "done" {
        decisionTrue = true
        }
        }
        */
        if worked {
            
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
