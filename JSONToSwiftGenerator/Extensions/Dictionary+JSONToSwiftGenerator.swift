//
//  Dictionary+JSONToSwiftGenerator.swift
//  JSONToSwiftGenerator
//
//  Created by Vlad Rusu on 6/27/16.
//  Copyright © 2016 VladR. All rights reserved.
//

import Foundation

protocol DictionaryJoinable {
    associatedtype Key: Hashable
    associatedtype Value
    
    mutating func join(withOther other:Dictionary<Self.Key, Self.Value>)
    
}

extension Dictionary: DictionaryJoinable {
    
    mutating func join(withOther other:Dictionary) {
        for (key, value) in other {
            self[key] = value
        }
    }
    
}
