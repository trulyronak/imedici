//
//  Reader.swift
//  iMedici
//
//  Created by Ronak Shah on 2/5/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//

import UIKit

class Reader {
    func readData() {
        let file = NSBundle.mainBundle().pathForResource("ChoiceTree", ofType: "txt")! //this is the file. we will write to and read from it
        
        if let reader = StreamReader(path: file) {
            var startChoice: String!
            var choices = [String:Choice]()
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
                        choices.updateValue(newChoice, forKey: nextWord!)
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
                var decision = Decision()
                while let line = reader.nextLine() {
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
                        }
                        else if line.wordAtIndex(0) == "decision" {
                            decisionTrue = true
                            contentTrue = false
                            choiceTrue = false
                        }
                            
                        else if contentTrue {
                            var text = line
                            var newContent = Content(text: text)
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
}
