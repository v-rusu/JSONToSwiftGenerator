//
//  Generator.swift
//  JSONToSwiftGenerator
//
//  Created by Vlad Rusu on 6/26/16.
//  Copyright © 2016 VladR. All rights reserved.
//

import Foundation

class Generator {
    
    let name: String
    let keyTypeDictionary: [String: String]
    
    var generators:[Generator.Type] = []
    
    required init(name:String, keyTypeDictionary: [String: String]) {
        self.name = name
        self.keyTypeDictionary = keyTypeDictionary
    }
    
    func generate() -> String {
        var generated = ""
        
        for generatorType in generators {
            let generator = generatorType.init(name: name, keyTypeDictionary: keyTypeDictionary)
            generated = generated + generator.generate() + "\n\n"
        }
        
        return generated
    }
    
}
