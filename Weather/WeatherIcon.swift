//
//  WeatherIcon.swift
//  Weather
//
//  Created by Pierre on 10/10/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import Foundation
import UIKit

class WeatherIcon {
    
    static func getWeatherIcon(icon: String) -> UIImage? {
        switch icon {
        case "01d":
            return UIImage(named: "clear_sky")!
        case "01n":
            return UIImage(named: "clear_sky_night")!
        case "02d":
            return UIImage(named: "few_clouds")!
        case "02n":
            return UIImage(named: "few_clouds_night")!
        case "03d":
            return UIImage(named: "scattered_clouds")!
        case "03n":
            return UIImage(named: "scattered_clouds")!
        case "04d":
            return UIImage(named: "broken_clouds")!
        case "04n":
            return UIImage(named: "broken_clouds")!
        case "09d":
            return UIImage(named: "shower_rain")!
        case "09n":
            return UIImage(named: "shower_rain")!
        case "10d":
            return UIImage(named: "rain")!
        case "10n":
            return UIImage(named: "rain")!
        case "11d":
            return UIImage(named: "thunderstorm")!
        case "11n":
            return UIImage(named: "thunderstorm")!
        case "13d":
            return UIImage(named: "snow")!
        case "13n":
            return UIImage(named: "snow")!
        case "50d":
            return UIImage(named: "mist")!
        case "50n":
            return UIImage(named: "mist")!
        default:
            break
        }
        
        return UIImage(named: "")
    }
    
}
