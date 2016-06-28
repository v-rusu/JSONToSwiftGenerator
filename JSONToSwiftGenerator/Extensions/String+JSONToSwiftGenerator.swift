//
//  String+JSONToSwiftGenerator.swift
//  JSONToSwiftGenerator
//
//  Created by Vlad Rusu on 6/25/16.
//  Copyright © 2016 VladR. All rights reserved.
//

import Foundation

extension String {
    
    enum CamelCaseFormat {
        case Upper, Lower
    }
    
    func camelCased(withFormat format: CamelCaseFormat) -> String {
        let components = componentsSeparatedByString("_")
        
        let camelCaseString = components.reduce("") { (result, component) -> String in
            if result != "" || format == .Upper {
                return result + component.capitalizedString
            } else {
                return component
            }
        }
        
        return camelCaseString
    }
    
    func genericType() -> String? {
        let components = componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: "<>"))
        
        if components.count > 1 {
            return components[1]
        } else {
            return nil
        }
    }
    
}
