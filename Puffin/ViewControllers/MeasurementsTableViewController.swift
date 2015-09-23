//
//  MeasurementsTableViewController.swift
//  Puffin
//
//  Created by Frank C. Eckert on 03/09/15.
//  Copyright (c) 2015 Frank C. Eckert. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

class MeasurementsTableViewController: UITableViewController {
    
    var measurements = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInitialData()
    }
    
    func loadInitialData() {
        saveMeasurement(5)
        saveMeasurement(8)
        tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.measurements.count
    }
    
    func getValue(measurement: NSManagedObject) -> String {
        if let value = measurement.valueForKey("value") as? NSNumber {
            return value.stringValue
        } else {
            return ""
        }
    }
    
    func getMeasuredAt(measurement: NSManagedObject) -> String {
        if let measuredAt = measurement.valueForKey("measuredAt") as? NSDate {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "hh:mm"
            return dateFormatter.stringFromDate(measuredAt)
        } else {
            return ""
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("ListPrototypeCell",  forIndexPath:indexPath) 
        let measurement = self.measurements[indexPath.row]
        cell.textLabel!.text = getValue(measurement)
        cell.detailTextLabel!.text = getMeasuredAt(measurement)
        return cell;
    }

    
    @IBAction func unwindToList(segue: UIStoryboardSegue) {
        let sourceController = segue.sourceViewController as! AddMeasurementViewController
        let possibleValue = sourceController.measurementValue
        if let value = possibleValue {
            saveMeasurement(value)
            tableView.reloadData()
        }
    }
        
    func saveMeasurement(value: Int16) {
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let measurement = NSEntityDescription.insertNewObjectForEntityForName("Measurement",
            inManagedObjectContext: managedContext) as! Measurement
        
        measurement.setValue(NSNumber(short: value), forKey: "value")
        measurement.setValue(NSDate(), forKey: "measuredAt")
        
        var error: NSError?
        do {
            try managedContext.save()
        } catch let error1 as NSError {
            error = error1
            print("Could not save \(error), \(error?.userInfo)")
        }  
        
        print("appending line")
        measurements.append(measurement)
        MeasurementUploader(measurement: measurement).upload()
        
        // create a corresponding local notification
        let notification = UILocalNotification()
        notification.alertBody = "May I have your tension?" // text that will be displayed in the notification
        notification.alertAction = "open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
        notification.fireDate = NSDate() // todo item due date (when notification will be fired)
        notification.soundName = UILocalNotificationDefaultSoundName // play default sound
//        notification.userInfo = ["UUID": item.UUID, ] // assign a unique identifier to the notification so that we can retrieve it later
        notification.category = "TODO_CATEGORY"
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
}
