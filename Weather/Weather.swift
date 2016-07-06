//
//  Weather.swift
//  Weather
//
//  Created by Pierre on 7/6/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import Foundation

class Weather {
    
    static let kWeather = "weather"
    static let kDescription = "description"
    
    static let kMain = "main"
    static let kTemperatue = "temp"
    static let kHumidity = "humidity"
	
    static let kWind = "wind"
    static let kSpeed = "speed"
    
    static let kName = "name"
    
    
    var description: String?
    var temperatureK: Float?
    var humidity: Float?
    var speed: Float?
    var cityName: String?
    
    var temperatureC: Float? {
        get {
            if let temperatureK = temperatureK {
                return temperatureK - 273.15
            } else {
                return nil
            }
        }
    }
    
    var temperatureF: Float? {
        get {
            if let temperatureK = temperatureK {
                return (temperatureK * 1.8) - 459.67
            } else {
                return nil
            }
        }
    }
    
    init?(jsonDictionary: [String:AnyObject]) {
        if let arrayWeatherKey = jsonDictionary[Weather.kWeather] as? [[String:AnyObject]] {
            if let description = arrayWeatherKey[0][Weather.kDescription] as? String {
                self.description = description
            }
        }
        
        if let mainDictionary = jsonDictionary[Weather.kMain] as? [String:AnyObject] {
            if let temperatureK = mainDictionary[Weather.kTemperatue] as? NSNumber {
                self.temperatureK = Float(temperatureK)
            }
        }
        
        if let windDictionary = jsonDictionary[Weather.kSpeed] as? [String:AnyObject] {
            if let speed = windDictionary[Weather.kSpeed] as? NSNumber {
                self.speed = Float(speed)
            }
        }
        
        if let cityName = jsonDictionary[Weather.kName] as? String {
            self.cityName = cityName
        }
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