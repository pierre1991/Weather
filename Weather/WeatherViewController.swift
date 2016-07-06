//
//  WeatherViewController.swift
//  Weather
//
//  Created by Pierre on 7/6/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    
    
    //MARK: IBOutlets
    @IBOutlet weak var searchField: UITextField!
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windspeedLabel: UILabel!

    
    
    //MARK: IBActions
    @IBAction func searchButtonTapped(sender: AnyObject) {
        if let text = searchField.text {
            WeatherController.getWeatherForCity(text, completion: { (result) in
                guard let weatherResult = result else {return}
                
                dispatch_async(dispatch_get_main_queue(), { 
                    self.cityName.text = weatherResult.cityName
                    
                    if let temperatureC = weatherResult.temperatureC {
                        self.temperatureLabel.text = String(temperatureC) + " C"
                    }
                    
                    self.descriptionLabel.text = weatherResult.description
                    
                    self.humidityLabel.text = String(weatherResult.humidity)
                    
                    self.windspeedLabel.text = String(weatherResult.speed)
                })
            })
        }
    }
}

