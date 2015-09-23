//
//  Measurement.swift
//  
//
//  Created by Frank C. Eckert on 04/09/15.
//
//

import Foundation
import CoreData

@objc(Measurement)
class Measurement: NSManagedObject {

    @NSManaged var value: NSNumber
    @NSManaged var measuredAt: NSDate

}
