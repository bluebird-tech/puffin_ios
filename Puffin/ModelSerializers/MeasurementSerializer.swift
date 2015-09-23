//
//  MeasurementSerializer.swift
//  Puffin
//
//  Created by Frank C. Eckert on 10/09/15.
//  Copyright (c) 2015 Frank C. Eckert. All rights reserved.
//

import Foundation
import CoreData

class MeasurementSerializer {
    var measurement: NSManagedObject
    
    init(measurement: NSManagedObject) {
        self.measurement = measurement
    }
    
    func asDict() -> [String: AnyObject] {
        return [
            "value": value(),
            "measuredAt": measuredAt()
        ]
    }
    
    func value() -> NSNumber {
        if let v = self.measurement.valueForKey("value") as? NSNumber {
            return v
        } else {
            return 0
        }
    }
    
    func measuredAt() -> String {
        if let m = measurement.valueForKey("measuredAt") as? NSDate {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            return dateFormatter.stringFromDate(m)
        } else {
            return ""
        }
    }
}

