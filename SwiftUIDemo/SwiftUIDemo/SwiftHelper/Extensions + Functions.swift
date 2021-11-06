//
//  Extensions + Functions.swift
//  MultiLvlJsonAPIDemo
//
//  Created by Ravi Patel on 02/08/21.
//

import UIKit

typealias Dictionary = [String:Any]

//MARK:- Extension
extension String {
    var isEmptyString: Bool {
        return trimmingCharacters(in: .whitespaces).count == 0
    }
}

extension Dictionary {
    var queryString: String {
        var output: String = ""
        for (key,value) in self {
            output +=  "\(key)=\(value)&"
        }
        output = String(output.dropLast())
        return output
    }
}

//MARK:- Functions
//Get Value from Dict
func getInteger(anything: Any?) -> Int
{
    if let any:Any = anything
    {
        if let num = any as? NSNumber
        {
            return num.intValue
        }
        else if let str = any as? NSString
        {
            return str.integerValue
        }
    }
    return 0
}

func getDouble(anything: Any?) -> Double
{
    if let any:Any = anything
    {
        if let num = any as? NSNumber
        {
            return num.doubleValue
        }
        else if let str = any as? NSString
        {
            return str.doubleValue
        }
    }
    return 0
}

func getFloat(anything: Any?) -> Float
{
    if let any:Any = anything
    {
        if let num = any as? NSNumber
        {
            return num.floatValue
        }
        else if let str = any as? NSString
        {
            return str.floatValue
        }
    }
    return 0
}

func getInteger64(anything: Any?) -> Int64
{
    if let any:Any = anything
    {
        if let num = any as? NSNumber
        {
            return num.int64Value
        }
        else if let str = any as? NSString
        {
            return str.longLongValue
        }
    }
    return 0
}

func getString(anything: Any?) -> String
{
    if let any:Any = anything
    {
        if let num = any as? NSNumber
        {
            return num.stringValue
        }
        else if let str = any as? String
        {
            return str
        }
        else if let char = any as? Character
        {
            return "\(char)"
        }
    }
    return ""
}

func getBoolean(anything: Any?) -> Bool
{
    if let any:Any = anything
    {
        if let num = any as? NSNumber
        {
            return num.boolValue
        }
        else if let str = any as? NSString
        {
            return str.boolValue
        }
    }
    return false
}

//MARK:- Print
func DebugLog(_ value: Any?) {
    if (isBeta) {
        if let value = value {
            print(value)
        }
    }
}

//MARK:- Read Json file
func readJsonFile(ofName: String) -> [String : Any] {
    guard let strPath = Bundle.main.path(forResource: ofName, ofType: ".json") else {
        return [:]
    }
    do {
        let data = try Data(contentsOf: URL(fileURLWithPath: strPath), options: .alwaysMapped)
        let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
        if let dictJson = jsonResult as? [String : Any] {
            return dictJson
        }
    } catch {
        print("Error!! Unable to parse ")
    }
    return [:]
}
