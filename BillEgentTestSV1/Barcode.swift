//
//  Barcode.swift
//  BillEgentTestSV1
//
//  Created by kuan-yu Chiang on 07/06/2017.
//  Copyright © 2017 kuan-yu Chiang. All rights reserved.
//

import Foundation
import CoreImage
import UIKit

class Parsr {
    
    
    class func parseData() {
        
        var barcodeArray = [Dictionary<String, String>]()
        var address = ""
        
        print(#function, #file)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if appDelegate.schemeCode != nil {
            
            print("Scheme Pass Success : \(appDelegate.schemeCode)")
            
            address = appDelegate.schemeCode
            
        }
        
        let fileListAPI = URL(string: "https://spreadsheets.google.com/feeds/list/" + "\(address)" + "/od6/public/values?alt=json")!
        
        //let fileListAPI = URL(string: "https://spreadsheets.google.com/feeds/list/15JjSTdtjJl292GLGXbstWS-92MHqR5a0xw5yzZf5rg8/od6/public/values?alt=json")!
        
        
        print(#function, #file)
        var returnDict:Dictionary = [String:String]()
        
        var request = URLRequest(url: fileListAPI)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let dataTask = URLSession.shared.dataTask(with: request) {
            
            (data, error, responsee) -> Void in
            
            if let data = data {
                do {
                    
                    let jsonDict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
                    
                    let jsonDictForFeed = jsonDict["feed"] as! [String: AnyObject]
                    let jsonArray = jsonDictForFeed["entry"] as! [[String: AnyObject]]
                    
                    for codeDict in jsonArray {
                        
                        let code1 = codeDict["gsx$code1"]!["$t"]! as! String
                        returnDict["code1"] = code1
                        let code2 = codeDict["gsx$code2"]!["$t"]! as! String
                        returnDict["code2"] = code2
                        let code3 = codeDict["gsx$code3"]!["$t"]! as! String
                        returnDict["code3"] = code3
                        
                        barcodeArray.append(returnDict)
                    }
                    
                    
                } catch {
                    
                    print(error)
                    
                }
            }
            
        }
        
        dataTask.resume()
        
    }
    
}




