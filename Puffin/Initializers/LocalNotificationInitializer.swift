//
//  LocalNotificationInitializer.swift
//  Puffin
//
//  Created by Frank C. Eckert on 04/09/15.
//  Copyright (c) 2015 Frank C. Eckert. All rights reserved.
//

import Foundation
import UIKit

class LocalNotificationInitializer {
    
    func initialize(application: UIApplication) {
        if UIDevice.currentDevice().model != "iPhone Simulator" {
            let types: UIUserNotificationType = [UIUserNotificationType.Alert, UIUserNotificationType.Sound]
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(forTypes: types, categories: Set<UIUserNotificationCategory>())
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
        }
    }

}