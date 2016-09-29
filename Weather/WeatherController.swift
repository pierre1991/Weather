//
//  WeatherController.swift
//  Weather
//
//  Created by Pierre on 7/6/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import Foundation

class WeatherController {
    
    //MARK: Properties
    
    
    
    
    static func getWeatherForCity(_ city: String, completion:@escaping (_ result: Weather?) -> Void) {
        let url = NetworkController.searchWeatherByCity(city)
        
        NetworkController.dataAtUrl(url, completion: { (resultData) -> Void in
            guard let resultData = resultData else {
                print("NO DATA RETURNED")
                completion(nil)
                return
            }
           
             do {
                let weatherAnyObject = try JSONSerialization.jsonObject(with: resultData, options: .allowFragments)
                
                var weatherModelObject: Weather?
                
                if let weatherDictionary = weatherAnyObject as? [String:AnyObject] {
                    weatherModelObject = Weather(jsonDictionary: weatherDictionary)
                }
                
                completion(weatherModelObject)
            } catch {
                completion(nil)
            }
        })
    }
}



/*
 {
 "coord": {
 "lon": -0.13,
 "lat": 51.51
 },
 "weather": [
 {
 "id": 800,
 "main": "Clear",
 "description": "clear sky",
 "icon": "01d"
 }
 ],
 "base": "cmc stations",
 "main": {
 "temp": 294.13,
 "pressure": 1022,
 "humidity": 43,
 "temp_min": 291.15,
 "temp_max": 297.59
 },
 "wind": {
 "speed": 3.1,
 "deg": 360
 },
 "clouds": {
 "all": 0
 },
 "dt": 1467822738,
 "sys": {
 "type": 1,
 "id": 5091,
 "message": 0.0078,
 "country": "GB",
 "sunrise": 1467777149,
 "sunset": 1467836275
 },
 "id": 2643743,
 "name": "London",
 "cod": 200
 }
 */
