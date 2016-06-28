//
//  FileCreator.swift
//  JSONToSwiftGenerator
//
//  Created by Vlad Rusu on 6/27/16.
//  Copyright © 2016 VladR. All rights reserved.
//

import Foundation

class FileCreator {
    
    let name: String
    let jsonObject: AnyObject
    let generatorType: Generator.Type
    
    init(name: String, jsonObject: AnyObject, generatorType: Generator.Type) {
        self.name = name
        self.jsonObject = jsonObject
        self.generatorType = generatorType
    }
    
    func create() {
        if !NSJSONSerialization.isValidJSONObject(jsonObject) {
            fatalError("Invalid JSON supplied")
        }
        
        let map:[String: [String: String]]
        if let dictObject = jsonObject as? [String: AnyObject] {
            let mapper = Mapper(name: name, jsonObject: dictObject)
            map = mapper.map()
        } else {
            fatalError("Top level Array JSONs not supported. Exiting")
        }
        
        for (key, value) in map {
            let generator = generatorType.init(name: key, keyTypeDictionary: value)
            
            let generatedSwiftStruct = generator.generate()
            try! generatedSwiftStruct.writeToFile("\(key).swift", atomically: false, encoding: NSUTF8StringEncoding)
        }
    }
    
}
