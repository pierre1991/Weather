//
//  WeatherController.swift
//  Weather
//
//  Created by Pierre on 7/6/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import Foundation

class WeatherController {
    
    static func getWeatherForCity(city: String, completion:(result: Weather?) -> Void) {
        let url = NetworkController.searchWeatherByCity(city)
        
        NetworkController.dataAtUrl(url, completion: { (resultData) -> Void in
            guard let resultData = resultData else {
                print("NO DATA RETURNED")
                completion(result: nil)
                return
            }
            do {
                let weatherAnyObject = try NSJSONSerialization.JSONObjectWithData(resultData, options: .AllowFragments)
                
                var weatherModelObject: Weather?
                
                if let weatherDictionary = weatherAnyObject as? [String:AnyObject] {
                    weatherModelObject = Weather(jsonDictionary: weatherDictionary)
                }
                completion(result: weatherModelObject)
            } catch {
                completion(result: nil)
            }
        })
    }
}

