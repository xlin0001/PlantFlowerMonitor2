//
//  Flower+CoreDataProperties.swift
//  
//
//  Created by 沈宇帆 on 2018/9/20.
//
//

import Foundation
import CoreData


extension Flower {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Flower> {
        return NSFetchRequest<Flower>(entityName: "Flower")
    }

    @NSManaged public var flowername: String?
    @NSManaged public var lights: String?
    @NSManaged public var maxtemp: Double
    @NSManaged public var mintemp: Double

}
