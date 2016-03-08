//
//  Extensions.swift
//  iMedici
//
//  Created by Ronak Shah on 2/9/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//


extension String {
    
    ///Returns the "index" number in the string (Counts like 0,1,2,3)
    func wordAtIndex(index: Int) -> String? {
        var words = self.componentsSeparatedByString(" ")
        return words[index]
    }
    
    ///Drops First Word (and space) in word
    func dropFirst() -> String? {
        var new = self
        let first = self.wordAtIndex(0)
        print(first?.characters.count)
        for var j = 0; j < first?.characters.count; j++ {
            new = String(new.characters.dropFirst())
        }
        return new
    }
    
}