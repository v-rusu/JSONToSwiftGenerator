//
//  Mapper.swift
//  JSONToSwiftGenerator
//
//  Created by Vlad Rusu on 6/25/16.
//  Copyright © 2016 VladR. All rights reserved.
//

import Foundation

class Mapper {
    
    let name: String
    let jsonObject: [String: AnyObject]
    
    init(name: String, jsonObject: [String: AnyObject]) {
        self.name = name
        self.jsonObject = jsonObject
    }
    
    func map() -> [String: [String: String]] {
        var map: [String: [String: String]] = [String: [String: String]]()
        var keyTypeDict: [String: String] = [String: String]()
        
        for (key, value) in jsonObject {
            var type = typeOf(value)
            
            if type.containsString("Array") {
                guard let firstItem = (value as! Array<AnyObject>).first else {
                    break;
                }
                
                var subtype = typeOf(firstItem)
                
                if subtype.containsString("Dictionary") {
                    subtype = key.camelCased(withFormat: .Upper)
                    
                    let subMapper = Mapper(name: key.camelCased(withFormat: .Upper), jsonObject: firstItem as! [String: AnyObject])
                    let subMap = subMapper.map()
                    
                    map.join(withOther: subMap)
                }
                
                type = "Array<\(subtype)>"
            } else if type.containsString("Dictionary") {
                type = key.camelCased(withFormat: .Upper)
                
                let subMapper = Mapper(name: key.camelCased(withFormat: .Upper), jsonObject: value as! [String: AnyObject])
                let subMap = subMapper.map()
                
                map.join(withOther: subMap)
            }
            
            keyTypeDict[key] = type
        }
        
        map[name] = keyTypeDict
        
        return map
    }
    
    // TODO: implement some kind of object to use instead of String
    private func typeOf(value: AnyObject) -> String {
        switch value {
            case let x where x is NSNumber: return typeOf(x as! NSNumber)
            case let x where x is String: return String(String.self)
            case let x where x is [AnyObject]: return String([AnyObject].self)
            case let x where x is [String: AnyObject]: return String([String: AnyObject].self)
            default: return ""
        }
    }
    
    private func typeOf(number: NSNumber) -> String {
        if number.isBool {
            return String(Bool.self)
        } else {
            let numberType = number.numberType
            switch numberType {
            case .NSIntegerType:
                return String(Int.self)
            case .DoubleType:
                return String(Double.self)
            default:
                return ""
            }
        }
    }

}
