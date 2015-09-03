//
//  AddMeasurementViewController.swift
//  
//
//  Created by Frank C. Eckert on 03/09/15.
//
//

import UIKit

class AddMeasurementViewController: UIViewController {
    
    @IBOutlet weak var value: UISlider!
    @IBOutlet weak var save: UIBarButtonItem!
    @IBOutlet weak var label: UILabel!
    
    var measurement: Measurement?

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (sender as! UIBarButtonItem) != self.save { return }
        var value = Int(round(self.value.value))
        self.measurement = Measurement(value: value, measuredAt: NSDate())
    }
    
    @IBAction func updateSliderLabel(sender: AnyObject) {
        label.text = String(Int(round(self.value.value)))
    }
}

