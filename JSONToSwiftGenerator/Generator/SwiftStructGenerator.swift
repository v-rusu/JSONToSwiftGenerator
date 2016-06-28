//
//  SwiftStructGenerator.swift
//  JSONToSwiftGenerator
//
//  Created by Vlad Rusu on 6/25/16.
//  Copyright © 2016 VladR. All rights reserved.
//

import Foundation

class SwiftStructGenerator : Generator {

    override func generate() -> String {
        var generated = ""
        
        generated = generated + generateMainStruct()
        
        return generated
    }

    private func generateMainStruct() -> String {
        var mainStructString = ""
        mainStructString = mainStructString + "struct \(name) {\n\n"
        
        for (key, type) in keyTypeDictionary {
            mainStructString = mainStructString + "\tlet \(key.camelCased(withFormat: .Lower)): \(type)?\n"
        }
        
        mainStructString = mainStructString + "\n}"
        
        return mainStructString
    }
    
}
