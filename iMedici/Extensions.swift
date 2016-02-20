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
        var words = self.componentsSeparatedByString(" ")
        return words[index]
    }
    
}