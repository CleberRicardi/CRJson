//
//  CRJson.swift
//  WeGo
//
//  Created by Cleber Ricardi on 20/03/15.
//  Copyright (c) 2015 Tagon 8. All rights reserved.
//

import Foundation
import UIKit

class CRJson {
    private var jsonDictionary:NSDictionary = NSDictionary()
    private var jsonArray:[CRJson] = [CRJson]()
    private var value:AnyObject?
    
    init (jsonDictionary:NSDictionary) {
        self.jsonDictionary = jsonDictionary
    }
    
    init (value:AnyObject? ) {
        self.value = value
    }
    
    init (jsonArray:[CRJson]) {
        self.jsonArray = jsonArray
    }
    
    init(){}
    
    subscript(key:String) ->CRJson {
        var json:CRJson?
        if let jsonDictionary = self.jsonDictionary[key] as? NSDictionary {
            json = Json(jsonDictionary: jsonDictionary)
        } else if let jsonNSArray = self.jsonDictionary[key] as? NSMutableArray {
            var jsonArray:[Json] = []
            for jsonRow in jsonNSArray {
                if let jsonDictionary:NSDictionary = jsonRow as? NSDictionary {
                    jsonArray.append(Json(jsonDictionary: jsonDictionary ))
                }
            }
            json = Json(jsonArray: jsonArray)
        } else {
            json = Json(value: self.jsonDictionary[key])
        }
        
        return json!
    }
    
    func getStringValue() ->String {
        if (self.value != nil) {
            if let stringReturn:String = self.value as? String {
                return stringReturn
            }
            if self.value as? NSNull == nil {
                return "\(self.value!)"
            }
        }
        return ""
    }
    
    func getFloatValue() ->CGFloat {
        if self.value != nil {
            if let floatReturn:CGFloat = self.value as? CGFloat {
                return floatReturn
            }
        }
        return 0.0
    }
    
    func getDoubleValue() ->Double {
        if self.value != nil {
            if let doubleReturn:Double = self.value as? Double {
                return doubleReturn
            }
        }
        return 0.0
    }
    
    func getIntValue() ->Int {
        if self.value != nil {
            if let intReturn:Int = Int("\(self.value!)") {
                return intReturn
            } else if let intReturn:Int = self.value as? Int {
                return intReturn
            }
        }
        return 0
    }
    
    func getBoolValue() ->Bool {
        if let boolReturn = self.value as? Bool {
            return boolReturn
        }
        return false
    }
    func getArray() ->[CRJson] {
        return self.jsonArray
    }
    func getDictionary() ->NSDictionary {
        return self.jsonDictionary
    }
    
    //json String
    func addValue(key key:String, value:AnyObject) ->Void {
        let mutable:NSMutableDictionary = NSMutableDictionary(dictionary: self.jsonDictionary)
        mutable.addEntriesFromDictionary([key:value])
        self.jsonDictionary = mutable
    }
    
    func addValue(key key:String, value:CRJson) ->Void {
        let mutable:NSMutableDictionary = NSMutableDictionary(dictionary: self.jsonDictionary)
        mutable.addEntriesFromDictionary([key:value.getDictionary()])
        self.jsonDictionary = mutable
    }
    
    func addArray(key key:String, value:[CRJson]) ->Void {
        var dictionary:[NSMutableDictionary] = [NSMutableDictionary]()
        for json in value {
            dictionary.append(NSMutableDictionary(dictionary: json.getDictionary()))
        }
        let mutable:NSMutableDictionary = NSMutableDictionary(dictionary: self.jsonDictionary)
        mutable.addEntriesFromDictionary([key:dictionary])
        self.jsonDictionary = mutable
    }

}