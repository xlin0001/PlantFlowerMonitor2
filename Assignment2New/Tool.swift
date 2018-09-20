//
//  Tool.swift
//  Assignment2New
//
//  Created by Oliver Lin on 19/9/18.
//  Copyright © 2018 Monash University. All rights reserved.
//

import Foundation

class Tool: NSObject{
    
    // this class function convers raspio Unix raw time formate to human readable time...
    class func convertUnixTimeToDate(timeIntervalSince1970: Int) -> String{
        let timeIntervalSince1970Double = Double(timeIntervalSince1970)
        let timeIntervalSince1970NSDate = NSDate(timeIntervalSince1970: timeIntervalSince1970Double)
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMddhhmm")
        let result = dateFormatter.string(from: timeIntervalSince1970NSDate as Date)
        return result
    }
}
