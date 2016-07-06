//
//  NetworkController.swift
//  Weather
//
//  Created by Pierre on 7/6/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import Foundation

class NetworkController {
    
    private static let API_KEY = "4b616d3821d8fe33cc71ba920b04c3ec"
    
    static let baseUrl = "http://api.openweathermap.org/data/2.5/weather"
    
    static func searchWeatherByCity(city: String) -> NSURL {
        let escapedString = city.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet())
        
        return NSURL(string: baseUrl + "?q=\(escapedString!)" + "&appid=\(API_KEY)")!
    }
    
    
    static func dataAtUrl(url: NSURL, completion:(resultData: NSData?) -> Void) {
        let session = NSURLSession.sharedSession()
        
        let dataTask = session.dataTaskWithURL(url) { (data, _, error) in
            guard let data = data else {
                print(error?.localizedDescription)
                completion(resultData: nil)
                return
            }
            completion(resultData: data)
        }
        dataTask.resume()
    }
}
