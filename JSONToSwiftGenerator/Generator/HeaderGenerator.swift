//
//  HeaderGenerator.swift
//  JSONToSwiftGenerator
//
//  Created by Vlad Rusu on 6/26/16.
//  Copyright © 2016 VladR. All rights reserved.
//

import Foundation

class HeaderGenerator : Generator {
    
    override func generate() -> String {
        var headerString = "//\n"
        headerString = headerString + "//  \(name).swift\n"
        headerString = headerString + "//\n"
        headerString = headerString + "//  Created by \(NSFullUserName()) on \(todayDateString())\n"
        headerString = headerString + "//  Copyright (c) \(yearDateString()) \(NSFullUserName()). All rights reserved.\n"
        headerString = headerString + "//"
        
        return headerString
    }
    
    private func todayDateString() -> String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .ShortStyle
        return formatter.stringFromDate(NSDate())
    }
    
    private func yearDateString() -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = NSDateFormatter.dateFormatFromTemplate("YYYY", options: 0, locale: NSLocale.currentLocale())
        return formatter.stringFromDate(NSDate())
    }
    
}
