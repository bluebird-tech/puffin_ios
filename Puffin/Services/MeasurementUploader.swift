//
//  MeasurementUploader.swift
//  Puffin
//
//  Created by Frank C. Eckert on 11/09/15.
//  Copyright © 2015 Frank C. Eckert. All rights reserved.
//

import Alamofire

class MeasurementUploader {
    
    var measurement: Measurement
    let URL = "https://glacial-lake-1827.herokuapp.com/events"
    
    init(measurement: Measurement) {
        self.measurement = measurement
    }

    func parameters() -> [String: AnyObject] {
        return MeasurementSerializer(measurement: measurement).asDict()
    }
    
    func upload() {
        Alamofire.request(.POST, URL, parameters: parameters(), encoding: .JSON)
            .responseJSON { _, _, result in
                print(result)
                debugPrint(result)
        }
    }
}