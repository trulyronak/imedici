//
//  Main.swift
//  iMedici
//
//  Created by Ronak Shah on 2/20/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//

import UIKit

var game = Main()

class Main {
    //MARK: - Variables
    var currentChoice: Choice?
    var story: StoryHandler!
    var reputation: Int
    var money: Double
    var VC: MainTableViewController!
    var lastChoice: String
    
    //MARK: - Init
    init(){
        //start game
        
        story = StoryHandler()
        story.readLevel()
        currentChoice = story.startChoice
        money = 500
        reputation = 3
        lastChoice = ""
    }
    
    //MARK: - Load Block
    func getCurrentBlock(tableViewController: MainTableViewController) -> [UITableViewCell]! {
        let tableView = tableViewController.tableView
        VC = tableViewController
        var block = [UITableViewCell]()
        
        if currentChoice?.identifier == "EVENT_SCORE"{
            var text: String!
            if reputation > 4 {
                text = "Congrats! Your decendant Leo, has become the POPE of the CATHOLIC CHURCH and is going his new found power to sponsor many more works of art. Congrats! Now, History has been saved"
            }
            else if reputation > 2 {
                text = "Congratish! While art won't be as good as it could have been, it will still be pretty great!"
            }
            else {
                text = "Uh oh! Art has lost some of its greatest accomplishments thanks to your terrible decision making. GG!"
            }
            let content = Content(text: text)
            tableView.registerNib(UINib(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: "contentCell")
            let newCell = tableView.dequeueReusableCellWithIdentifier("contentCell") as! ContentTableViewCell
            newCell.contentTextView.text = content.text
            newCell.contentTextView.font = UIFont(name: "Futura", size: 14)
            newCell.contentTextView.textColor = UIColor.whiteColor()
            
            block.append(newCell)
        }
        else if currentChoice?.identifier == "EVENT_BANKRUPT" || currentChoice?.identifier == "EVENT_GGREP" {
            let content = currentChoice?.content
            tableView.registerNib(UINib(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: "contentCell")
            let newCell = tableView.dequeueReusableCellWithIdentifier("contentCell") as! ContentTableViewCell
            newCell.contentTextView.text = content!.text
            newCell.contentTextView.font = UIFont(name: "Futura", size: 14)
            newCell.contentTextView.textColor = UIColor.whiteColor()
            block.append(newCell)
        }
        else {
            //MARK: - Creating Content Block
            let content = currentChoice?.content
            
            //let contentSectionWrapped = tableView.dequeueReusableCellWithIdentifier("contentCell") as? ContentTableViewCell
            tableView.registerNib(UINib(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: "contentCell")
            let contentSection = tableView.dequeueReusableCellWithIdentifier("contentCell") as! ContentTableViewCell
            
            contentSection.identifier = currentChoice?.identifier
            contentSection.contentTextView.text = content?.text
            contentSection.contentTextView.textColor = UIColor.whiteColor()
            contentSection.contentTextView.font = UIFont(name: "Futura", size: 14)
            contentSection.contentTextView.frame = CGRectMake(8, 9, 384, 320)
            contentSection.frame = CGRectMake(38, 0, 324, 72)
            block.append(contentSection)
            if currentChoice?.identifier == "INTRO" {
                contentSection.frame = CGRectMake(38, 0, 324, 400)
            }
            
            //MARK: - Creating Decision Block
            let decision: Decision = (currentChoice?.decision)!
            tableView.registerNib(UINib(nibName: "DecisionTableViewCell", bundle: nil), forCellReuseIdentifier: "decisionCell")
            tableView.registerNib(UINib(nibName: "SingleChoiceDecisionTableViewCell", bundle: nil), forCellReuseIdentifier: "singleDecision")
            if currentChoice!.isSingle() {
                //MARK: - Single Choice
                let decisionSection = tableView.dequeueReusableCellWithIdentifier("singleDecision") as! SingleChoiceDecisionTableViewCell
                
                decisionSection.identifier = currentChoice!.identifier
                decisionSection.rightPanel.text = ""
                decisionSection.prompt.text = ""
                print(decisionSection.heightAnchor)
                decisionSection.rightPanel.frame = CGRectMake(8, 144, 384, 128)
                decisionSection.prompt.frame = CGRectMake(8, 8, 384, 128)
                
                decisionSection.prompt.text = currentChoice!.decision.prompt
                decisionSection.prompt.textColor = UIColor.whiteColor()
                decisionSection.prompt.font = UIFont(name: "Futura", size: 14)
                
                //right panel
                
                if ((decision.rightImageTrue())) {
                    let image = UIImageView(image: decision.rightImage)
                    decisionSection.rightPanel.addSubview(image)
                }
                if decision.rightTextTrue() {
                    decisionSection.rightPanel.text! += decision.rightText!
                    decisionSection.rightPanel.text! += "\n"
                }
                if decision.rightBulletPointsTrue() {
                    decisionSection.rightPanel.text! += "\n"
                    for bullet in decision.rightBulletPoints! {
                        
                        decisionSection.rightPanel.text! += " - "
                        decisionSection.rightPanel.text! += bullet
                        decisionSection.rightPanel.text! += "\n"
                    }
                    decisionSection.rightPanel.text! += "\n"
                }
                if decision.moneyEarned != nil {
                    decisionSection.rightPanel.text! += "$"
                    decisionSection.rightPanel.text! +=  "\(decision.moneyEarned!)"
                    decisionSection.rightPanel.text! += "\n"
                }
                decisionSection.rightPanel.textColor = UIColor.whiteColor()
                decisionSection.rightPanel.font = UIFont(name: "Futura", size: 14)
                block.append(decisionSection)
            }
            else {
                //MARK: - Normal Decision
                let decisionSection = tableView.dequeueReusableCellWithIdentifier("decisionCell") as! DecisionTableViewCell
                decisionSection.identifier = currentChoice?.identifier
                decisionSection.rightPanel.text = ""
                decisionSection.leftPanel.text = ""
                decisionSection.prompt.text = ""
                print(decisionSection.heightAnchor)
                decisionSection.rightPanel.frame = CGRectMake(212, 88, 149, 202)
                decisionSection.leftPanel.frame = CGRectMake(38, 88, 166, 202)
                decisionSection.prompt.frame = CGRectMake(38, 8, 323, 72)
                
                decisionSection.prompt.text = currentChoice?.decision.prompt
                decisionSection.prompt.textColor = UIColor.whiteColor()
                decisionSection.prompt.font = UIFont(name: "Futura", size: 14)
                
                //right panel
                
                if ((decision.rightImageTrue())) {
                    let image = UIImageView(image: decision.rightImage)
                    decisionSection.rightPanel.addSubview(image)
                }
                if decision.rightTextTrue() {
                    decisionSection.rightPanel.text! += decision.rightText!
                    decisionSection.rightPanel.text! += "\n"
                }
                if decision.rightBulletPointsTrue() {
                    decisionSection.rightPanel.text! += "\n"
                    for bullet in decision.rightBulletPoints! {
                        
                        decisionSection.rightPanel.text! += " - "
                        decisionSection.rightPanel.text! += bullet
                        decisionSection.rightPanel.text! += "\n"
                    }
                    decisionSection.rightPanel.text! += "\n"
                }
                if decision.moneyEarned != nil {
                    decisionSection.rightPanel.text! += "$"
                    decisionSection.rightPanel.text! +=  "\(decision.moneyEarned!)"
                    decisionSection.rightPanel.text! += "\n"
                }
                decisionSection.rightPanel.textColor = UIColor.whiteColor()
                decisionSection.rightPanel.font = UIFont(name: "Futura", size: 14)
                //left panel
                if ((decision.leftImageTrue())) {
                    let image = UIImageView(image: decision.leftImage)
                    decisionSection.rightPanel.addSubview(image)
                }
                if decision.leftTextTrue() {
                    decisionSection.leftPanel.text! += decision.leftText!
                    decisionSection.leftPanel.text! += "\n"
                }
                if decision.leftBulletPointsTrue() {
                    decisionSection.leftPanel.text! += "\n"
                    for bullet in decision.leftBulletPoints! {
                        
                        decisionSection.leftPanel.text! += " - "
                        decisionSection.leftPanel.text! += bullet
                        decisionSection.leftPanel.text! += "\n"
                    }
                    decisionSection.leftPanel.text! += "\n"
                }
                if decision.cost != nil{
                    if decision.cost == 0 {}
                    else {
                        decisionSection.leftPanel.text! += "$"
                        decisionSection.leftPanel.text! +=  "\(decision.cost!)"
                        decisionSection.leftPanel.text! += "\n"
                    }
                }
                decisionSection.leftPanel.textColor = UIColor.whiteColor()
                decisionSection.leftPanel.font = UIFont(name: "Futura", size: 14)
                
                
                block.append(decisionSection)
            }
        }
        return block
    }
    
    //MARK: - Navigation Methods
    func moveRight() {
        lastChoice = (currentChoice?.identifier)!
        print("Moving From \(currentChoice?.identifier)")
        if currentChoice?.right == "EVENT_1" {
            print("Stuff")
        }
        if currentChoice?.identifier == "EVENT_1" {
            currentChoice?.major = 1
            major()
        }
        else if currentChoice?.identifier == "EVENT_FINAL" {
           currentChoice = story.choices["EVENT_SCORE"]
        }
        else {
            if ((currentChoice?.decision.allowMoney)! == true) {
                money += (currentChoice?.decision.moneyEarned)!
            }
            
                currentChoice = story.choices[(currentChoice?.right)!]
                reputation -= 1
            
        }
        if money < 0 {
           currentChoice = story.choices["EVENT_BANKRUPT"]
        }
        else if reputation < -4 {
            currentChoice = story.choices["EVENT_GGREP"]
        }
        VC.loadCells()
        print("To \(currentChoice?.identifier)")
        
    }
    func moveLeft() {
        lastChoice = (currentChoice?.identifier)!
        print("Moving From \(currentChoice?.identifier)")
        if currentChoice?.right == "EVENT_1" {
            print("Stuff")
        }
        if currentChoice?.identifier == "EVENT_1" {
            currentChoice?.major = 1
            major()
        }
        else if currentChoice?.identifier == "EVENT_FINAL" {
            currentChoice = story.choices["EVENT_SCORE"]
        }
        else {
            money -= (currentChoice?.decision.cost!)!
            reputation += (currentChoice?.decision.leftReputation)!
            currentChoice = story.choices[(currentChoice?.left)!]
        }
        if money < 0 {
            currentChoice = story.choices["EVENT_BANKRUPT"]
        }
        else if reputation < -4 {
            currentChoice = story.choices["EVENT_GGREP"]
        }
        VC.loadCells()
        print("To \(currentChoice?.identifier)")
    }
    
    
    //MARK: - Major Code
    func major() {
        let num: Int = (currentChoice?.major)!
        switch  num{
        case 1:
            if reputation > 30 && money < 5000{
                currentChoice = story.choices["XA"]
            }
            else {
                currentChoice = story.choices["YA"]
            }
            
            break
        case 2:
            let choice = Choice(identity: "EVENT_FINAL")
            let content = Content(text: "Congrats! You've Reached The End!!")
            let decision = Decision()
            decision.leftText = "G"
            decision.rightText = "G"
            choice.content = content
            choice.decision = decision
            currentChoice = choice
        default:
            break
        }
    }
}