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
    var currentChoice: Choice?
    var story: StoryHandler!
    var reputation: Int
    var money: Double
    
    init(){
        //start game
        
        story = StoryHandler()
        story.readLevel()
        currentChoice = story.startChoice
        money = 10000
        reputation = 0
    }
    
    //TODO: Figure out why prompt is not loading
    func getCurrentBlock(tableView: UITableView) -> [UITableViewCell]! {
        var block = [UITableViewCell]()
        
        //content
        let content = currentChoice?.content
        
        let contentSection = tableView.dequeueReusableCellWithIdentifier("contentCell") as! ContentTableViewCell
        contentSection.identifier = currentChoice?.identifier
        contentSection.contentTextView.text = content?.text
        contentSection.contentTextView.textColor = UIColor.whiteColor()
        contentSection.contentTextView.font = UIFont(name: "Futura", size: 14)
        contentSection.frame = CGRectMake(38, 0, 324, 72)
        block.append(contentSection)
        if currentChoice?.identifier == "INTRO" {
            contentSection.frame = CGRectMake(38, 0, 324, 400)
        }
        
        //decision
        let decision: Decision = (currentChoice?.decision)!
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
            for bullet in decision.rightBulletPoints! {
                decisionSection.rightPanel.text! += bullet
                decisionSection.rightPanel.text! += "\n"
            }
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
            for bullet in decision.leftBulletPoints! {
                decisionSection.leftPanel.text! += bullet
                decisionSection.leftPanel.text! += "\n"
            }
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
        
        return block
    }
    
    func moveRight() {
        if currentChoice?.major != 0 {}
        else {
            if ((currentChoice?.decision.allowMoney)! == true) {
                money += (currentChoice?.decision.moneyEarned)!
            }
            currentChoice = story.choices[(currentChoice?.right)!]
            reputation -= 1
        }
    }
    func moveLeft() {
        if currentChoice?.major != 0 {}
        else {
            money -= (currentChoice?.decision.cost!)!
            reputation += (currentChoice?.decision.leftReputation)!
            currentChoice = story.choices[(currentChoice?.left)!]
        }
    }
}