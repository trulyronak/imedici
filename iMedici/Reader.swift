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
            while let line = reader.nextLine() {
                
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
