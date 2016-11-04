//
//  SettingsLocationView.swift
//  Weather
//
//  Created by Pierre on 10/31/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import UIKit

protocol SettingsLocationViewDelegate: class {
    func blurEffectRemoved(_ sender: SettingsLocationView)
    func showNavigationBar()
}

class SettingsLocationView: UIView {

    
    //MARK: Delegate
    weak var settingsViewDelegate: SettingsLocationViewDelegate?
    
    
	//MARK: IBActions
    @IBAction func settingsButtonTapped(_ sender: Any) {
        if let appSettings = URL(string: UIApplicationOpenSettingsURLString) {
            UIApplication.shared.open(appSettings, options: [:], completionHandler: { (finished) in
                self.dismissAlertView()
                self.settingsViewDelegate?.showNavigationBar()
            })
        }

        self.settingsViewDelegate?.showNavigationBar()
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut, animations: {
        	self.alpha = 0
            self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        	}, completion: {(finish) in
            	self.dismissAlertView()
            	self.settingsViewDelegate?.showNavigationBar()
        })
    }
    
    
    //MARK: Helper Functions
    func dismissAlertView() {
        self.removeFromSuperview()
        self.settingsViewDelegate?.blurEffectRemoved(self)
    }
    
}
