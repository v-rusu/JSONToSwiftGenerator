//
//  NSNumber+JSONToSwiftGenerator.swift
//  JSONToSwiftGenerator
//
//  Created by Vlad Rusu on 6/26/16.
//  Copyright © 2016 VladR. All rights reserved.
//

import Foundation

extension NSNumber {
    
    private var trueNumber:NSNumber { return NSNumber(bool: true) }
    private var falseNumber:NSNumber { return NSNumber(bool: false) }
    private var trueObjCType:String? { return String.fromCString(trueNumber.objCType) }
    private var falseObjCType:String? { return String.fromCString(falseNumber.objCType) }
    
    var isBool:Bool {
        get {
            let objCType = String.fromCString(self.objCType)
            if (self.compare(trueNumber) == NSComparisonResult.OrderedSame && objCType == trueObjCType)
                || (self.compare(falseNumber) == NSComparisonResult.OrderedSame && objCType == falseObjCType){
                return true
            } else {
                return false
            }
        }
    }
    
    var numberType:CFNumberType {
        get {
            var numberRef = CFNumberGetType(self)
            
            // ignoring uncommon types
            switch numberRef {
                case .SInt8Type: fallthrough
                case .SInt16Type: fallthrough
                case .SInt32Type: fallthrough
                case .SInt64Type: fallthrough
                case .CharType: fallthrough
                case .ShortType: fallthrough
                case .IntType: fallthrough
                case .LongType: fallthrough
                case .LongLongType: fallthrough
                case .CFIndexType: fallthrough
                case .NSIntegerType: numberRef = .NSIntegerType
                case .Float32Type: fallthrough
                case.Float64Type: fallthrough
                case .CGFloatType: fallthrough
                case .FloatType: fallthrough
                case .DoubleType: numberRef = .DoubleType
            }
            
            return numberRef
        }
    }
    
}
