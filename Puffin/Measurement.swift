//
//  Measurement.swift
//  Puffin
//
//  Created by Frank C. Eckert on 03/09/15.
//  Copyright (c) 2015 Frank C. Eckert. All rights reserved.
//

import Foundation

class Measurement: NSObject {
    var value: NSNumber
    var measuredAt: NSDate
    
    init(value: NSNumber, measuredAt: NSDate) {
        self.value = value
        self.measuredAt = measuredAt
    }
    
    func measuredAtString() -> NSString {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        return dateFormatter.stringFromDate(measuredAt)
    }
}