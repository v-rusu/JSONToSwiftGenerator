//
//  main.swift
//  JSONToSwiftGenerator
//
//  Created by Vlad Rusu on 6/25/16.
//  Copyright © 2016 VladR. All rights reserved.
//

import Foundation

// TODO: implement help

// Get the filename from the supplied arguments list
if Process.arguments.count <= 1 {
    fatalError("No filename supplied!")
}

let filename = Process.arguments[1]

// JSON deserialization
guard let data = NSData(contentsOfFile: filename) else {
    fatalError("Invalid file supplied!")
}

let jsonObject: AnyObject
do {
    jsonObject = try NSJSONSerialization.JSONObjectWithData(data, options: [])
} catch {
    fatalError("Could not deserialize JSON")
}

// Get the name of the first object based on the filename
let name = ((filename as NSString).lastPathComponent as NSString).stringByDeletingPathExtension

// Start creating the files
let fileCreator = FileCreator(name: name, jsonObject: jsonObject, generatorType: SwiftStructFileGenerator.self)
fileCreator.create()
