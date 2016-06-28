//
//  SwiftStructFileGenerator.swift
//  JSONToSwiftGenerator
//
//  Created by Vlad Rusu on 6/26/16.
//  Copyright © 2016 VladR. All rights reserved.
//

import Foundation

class SwiftStructFileGenerator : Generator {
    
    required init(name: String, keyTypeDictionary: [String : String]) {
        super.init(name: name, keyTypeDictionary: keyTypeDictionary)
        
        generators = [HeaderGenerator.self, SwiftStructGenerator.self, SwiftStructExtensionGenerator.self]
    }
    
}
