//
//  NetworkController.swift
//  Weather
//
//  Created by Pierre on 7/6/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import Foundation

class NetworkController {
    
    fileprivate static let API_KEY = "4b616d3821d8fe33cc71ba920b04c3ec"
    
    static let baseUrl = "http://api.openweathermap.org/data/2.5/weather"
    
    
    static func searchWeatherByCity(_ city: String) -> URL {
        let escapedString = city.addingPercentEncoding(withAllowedCharacters: CharacterSet())
        
        return URL(string: baseUrl + "?q=\(escapedString!)" + "&appid=\(API_KEY)")!
    }
    
    
    static func dataAtUrl(_ url: URL, completion:@escaping (_ resultData: Data?) -> Void) {
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url, completionHandler: { (data, _, error) in
            guard let data = data else {
                print(error?.localizedDescription)
                completion(nil)
                return
            }
            
            completion(data)
        }) 
        
        dataTask.resume()
    }
}
