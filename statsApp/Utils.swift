//
//  Utils.swift
//  statsApp
//
//  Created by Federico Lopez on 21/01/2020.
//  Copyright © 2020 Federico Lopez. All rights reserved.
//

import UIKit

// MARK: Local Notifications
let nUpdateActivities = Notification.Name("Notification -> UpdateActivities")

func SEND_NOTIFICATION(_ notName: Notification.Name) {
    NotificationCenter.default.post(name: notName, object: nil, userInfo: nil)
}

// MARK: Alerts
func ALERT(text: String, viewController: UIViewController, callback: @escaping (Bool)->() ) {
    let alert = UIAlertController(title: "appTitle", message: text, preferredStyle: .alert)
    let yesAction = UIAlertAction(title: "Yes", style: .default) { (alertAction) in
        callback(true)
    }
    let noAction = UIAlertAction(title: "No", style: .cancel) { (alertAction) in
        callback(false)
    }
    
    alert.addAction(yesAction)
    alert.addAction(noAction)
    viewController.present(alert, animated: true) {
    }
}

// MARK: misc
func ERROR_CODE(_ error: Error?) -> Int {
    var result = 0
    if let E = error as NSError? {
        result = E.code
        print(">>> ERROR", E.code, E.description)
    }
    
    return result
}







func TRACE(_ text: String) {
    print(">>", text)
}


