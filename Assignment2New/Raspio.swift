//
//  File.swift
//  Assignment2New
//
//  Created by Oliver Lin on 19/9/18.
//  Copyright © 2018 Monash University. All rights reserved.
//
import UIKit
import Foundation

internal class Raspio: NSObject {
    internal let id : Int
    internal let name : String
    internal let red : Double
    internal let blue : Double
    internal let green : Double
    internal let temp : Double
    internal let pressure : Double
    internal let altimeter : Double
    init(id: Int, name: String,red: Double, blue: Double, green: Double, temp: Double,pressure : Double,altimeter : Double) {
        self.id = id
        self.name = name
        self.red = red
        self.blue = blue
        self.green = green
        self.temp = temp
        self.altimeter = altimeter
        self.pressure = pressure
    }
}


