//
//  MeasurementsTableViewController.swift
//  Puffin
//
//  Created by Frank C. Eckert on 03/09/15.
//  Copyright (c) 2015 Frank C. Eckert. All rights reserved.
//

import UIKit

class MeasurementsTableViewController: UITableViewController {
    
    var measurements = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInitialData()
    }
    
    func loadInitialData() {
        var measurement1 = Measurement(value: 5, measuredAt: NSDate())
        self.measurements.addObject(measurement1)
        var measurement2 = Measurement(value: 6, measuredAt: NSDate())
        self.measurements.addObject(measurement2)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.measurements.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("ListPrototypeCell",  forIndexPath:indexPath) as! UITableViewCell
        var measurement: Measurement = self.measurements.objectAtIndex(indexPath.row) as! Measurement
        cell.textLabel!.text = measurement.value.stringValue
        cell.detailTextLabel!.text = measurement.measuredAtString() as String
        return cell;
    }
    
    @IBAction func unwindToList(segue: UIStoryboardSegue) {
        var controller = segue.sourceViewController as! AddMeasurementViewController
        var possibleMeasurement = controller.measurement
        if let measurement = possibleMeasurement {
            measurements.addObject(measurement)
            tableView.reloadData()
        }
    }
}
