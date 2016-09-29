//
//  Weather.swift
//  Weather
//
//  Created by Pierre on 7/6/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import Foundation

class Weather {
    
    private let kWeather = "weather"
    private let kCoordinates = "coordinates"
    private let kDescription = "description"
    private let kMain = "main"
    private let kTemperatue = "temp"
    private let kHumidity = "humidity"
	private let kWind = "wind"
    private let kSpeed = "speed"
    private let kName = "name"
    
    
    var coordinates: [String:AnyObject]?
    var description: String?
    var temperatureK: Double?
    var humidity: Double?
    var speed: Double?
    var cityName: String?
    
    var temperatureC: Double? {
        get {
            if let temperatureK = temperatureK {
                return temperatureK - 273.15
            } else {
                return nil
            }
        }
    }
    
    var temperatureF: Double? {
        get {
            if let temperatureK = temperatureK {
                return (temperatureK * 1.8) - 459.67
            } else {
                return nil
            }
        }
    }
    
    
    init?(jsonDictionary: [String:AnyObject]) {
        if let coord = jsonDictionary[kCoordinates] as? [String:AnyObject] {
            self.coordinates = coord
        }
        
        if let arrayWeatherKey = jsonDictionary[kWeather] as? [[String:AnyObject]] {
            if let description = arrayWeatherKey[0][kDescription] as? String {
                self.description = description
            }
        }
        
        if let mainDictionary = jsonDictionary[kMain] as? [String:AnyObject] {
            if let temperatureK = mainDictionary[kTemperatue] as? NSNumber {
                self.temperatureK = Double(temperatureK)
            }
            if let humidity = mainDictionary[kHumidity] as? NSNumber {
                self.humidity = Double(humidity)
            }
        }
        
        if let windDictionary = jsonDictionary[kWind] as? [String:AnyObject] {
            if let speed = windDictionary[kSpeed] as? NSNumber {
                self.speed = Double(speed)
            }
        }
        
        if let cityName = jsonDictionary[kName] as? String {
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
