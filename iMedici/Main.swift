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
    init(){
        //start game
        
        story = StoryHandler()
        story.readLevel()
        currentChoice = story.startChoice
    }
    
    func getCurrentBlock() -> [UITableViewCell]! {
        var block = [UITableViewCell]()
        
        //content
        let content = currentChoice?.content
        
        let contentSection = ContentTableViewCell()
        var textView = UITextView()
        textView.text! += (content?.text)!
        contentSection.contentTextView = textView

        block.append(contentSection)
        
        //decision
        let decision = currentChoice?.decision
        let decisionSection = DecisionTableViewCell()
        //adding picture
        
        textView = UITextView()

        
        
       return block
    }
}