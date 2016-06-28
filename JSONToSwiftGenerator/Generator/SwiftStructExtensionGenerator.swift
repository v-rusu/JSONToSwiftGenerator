//
//  SwiftStructExtensionGenerator.swift
//  JSONToSwiftGenerator
//
//  Created by Vlad Rusu on 6/26/16.
//  Copyright © 2016 VladR. All rights reserved.
//

import Foundation

class SwiftStructExtensionGenerator: Generator {
    
    override func generate() -> String {
        var dictExtensionString = ""
        
        dictExtensionString = dictExtensionString + "extension \(name) {\n\n"
        dictExtensionString = dictExtensionString + generateKeysEnum() + "\n\n"
        dictExtensionString = dictExtensionString + generateDictInit() + "\n\n"
        dictExtensionString = dictExtensionString + generateToDictFunc()
        dictExtensionString = dictExtensionString + "\n\n}"
        
        return dictExtensionString
    }
    
    private func generateKeysEnum() -> String {
        var keysEnumString = ""
        keysEnumString = keysEnumString + "\tprivate enum Keys: String {\n"
        
        for (key, _) in keyTypeDictionary {
            keysEnumString = keysEnumString + "\t\tcase \(key.camelCased(withFormat: .Upper)) = \"\(key)\"\n"
        }
        
        keysEnumString = keysEnumString + "\t}"
        
        return keysEnumString
    }
    
    private func generateDictInit() -> String {
        var dictInitString = ""
        
        dictInitString = dictInitString + "\tinit(dict: [String: AnyObject]) {\n"
        
        for (key, type) in keyTypeDictionary {
            var assignString = "\t\t\(key.camelCased(withFormat: .Lower)) = dict[\(name).Keys.\(key.camelCased(withFormat: .Upper)).rawValue] as? \(type)\n"
            
            if type.containsString("Array") {
                let subtype = type.genericType()!
                
                if !isFoundationType(subtype) {
                    assignString = "\t\t\(key.camelCased(withFormat: .Lower)) = (dict[\(name).Keys.\(key.camelCased(withFormat: .Upper)).rawValue] as? Array<[String: AnyObject]>)?.map(\(subtype).init(dict:))\n"
                }
            }
            
            dictInitString = dictInitString + assignString
        }
        
        dictInitString = dictInitString + "\t}"
        
        return dictInitString
    }
    
    private func generateToDictFunc() -> String {
        var toDictFuncString = ""
        
        toDictFuncString = toDictFuncString + "\tfunc toDictionary() -> [String: AnyObject] {\n"
        toDictFuncString = toDictFuncString + "\t\tvar dict: [String: AnyObject] = [String: AnyObject]()\n\n"
        
        for (key, type) in keyTypeDictionary {
            let propertyKey = key.camelCased(withFormat: .Lower)
            toDictFuncString = toDictFuncString + "\t\tif let \(propertyKey) = \(propertyKey) {\n"
            
            var assignString = "\t\t\tdict[\(name).Keys.\(key.camelCased(withFormat: .Upper)).rawValue] = \(propertyKey)"
            if type.containsString("Array") {
                let subtype = type.genericType()!
                
                if !isFoundationType(subtype) {
                    assignString = "\t\t\tdict[\(name).Keys.\(key.camelCased(withFormat: .Upper)).rawValue] = \(propertyKey).map { $0.toDictionary() }"
                }
                
            }
            
            toDictFuncString = toDictFuncString + assignString
            toDictFuncString = toDictFuncString + "\n\t\t}\n\n"
        }
        
        toDictFuncString = toDictFuncString + "\t\treturn dict\n\t}"
        
        return toDictFuncString
    }
    
    private func isFoundationType(type: String) -> Bool {
        if type.containsString("String") || type.containsString("Double") || type.containsString("Bool") || type.containsString("Int") || type.containsString("Array") || type.containsString("Dictionary") {
            return true
        }
        
        return false
    }
    
}
