//
//  UIViewController+Extension.swift
//  NYCHighSchools
//
//  Created by Rambabu on 20/12/23.
//

import Foundation
import UIKit

extension UIViewController {
    
    /// to display alert in all UIViewController subclasses
    func showAlert(title: String, message: String, actionTitle: String) {
        // Create the alert controller
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // Create the actions
        let okAction = UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default) {
            UIAlertAction in
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

    /**
     *
     * Convert unix time to human readable time. Return empty string if unixtime
     * argument is 0. Note that EMPTY_STRING = ""
     *
     * @param unixdate the time in unix format, e.g. 1482505225
     * @param timezone the user's time zone, e.g. EST, PST
     * @return the date and time converted into human readable String format
     *
     **/
    
    func displayNetworkFailureAlert() {
        showAlert(title: "Internet connection FAILED", message: "Make sure your device is connected to the internet.", actionTitle: "Okay")
    }

}
