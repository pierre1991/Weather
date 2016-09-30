//
//  AppearanceController.swift
//  Weather
//
//  Created by Pierre on 9/29/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import Foundation
import UIKit

class AppearanceController {
    
    static func initializeAppearance() {
    	UINavigationBar.appearance().barTintColor = UIColor.mediumDarkBlue()
        UINavigationBar.appearance().tintColor = UIColor.white
    }
    
//    static func setStatusBarBackgroundColor(_ color: UIColor) {
//        guard let statusBar = (UIApplication.shared.value(forKey: "statusBarWindow") as AnyObject).value(forKey: "statusBar") as? UIView else {return}
//        
//        statusBar.backgroundColor = UIColor.mediumDarkBlue()
//    }

}
