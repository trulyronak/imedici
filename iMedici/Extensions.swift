//
//  Extensions.swift
//  iMedici
//
//  Created by Ronak Shah on 2/9/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//

import Foundation

extension String {
    
    ///Returns the "index" number in the string (Counts like 0,1,2,3)
    func wordAtIndex(index: Int) -> String? {
        let word = self
        var finalWord = ""
        var wordNumber = 0
        
        for character in word.characters {
            if character == " "{
                if wordNumber == index {
                    return word
                }
                wordNumber++
            }
            else {
                finalWord.append(character)
            }
        }
    }
}