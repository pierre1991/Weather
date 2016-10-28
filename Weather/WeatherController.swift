//
//  WeatherController.swift
//  Weather
//
//  Created by Pierre on 7/6/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import Foundation

class WeatherController {
    
    private let kCity = "city"
    static let sharedController = WeatherController()
    
    
    //MARK: Properties
    var cityArray: [City]
    
    
    init() {
        self.cityArray = []
        self.loadFromPersistantStorage()
    }
    
    
    
    //MARK: Builder Functions
    static func getWeatherForCity(_ city: String, completion:@escaping (_ result: City?) -> Void) {
        let url = NetworkController.searchWeatherByCity(city)
        
        NetworkController.dataAtUrl(url, completion: { (resultData) -> Void in
            guard let resultData = resultData else {
                print("NO DATA RETURNED")
                completion(nil)
                return
            }
           
             do {
                let weatherAnyObject = try JSONSerialization.jsonObject(with: resultData, options: .allowFragments)
                
                var weatherModelObject: City?
                
                if let weatherDictionary = weatherAnyObject as? [String:AnyObject] {
                    weatherModelObject = City(jsonDictionary: weatherDictionary)
                }
                
                completion(weatherModelObject)
            } catch {
                completion(nil)
            }
        })
    }
    
    static func getWeatherForLocation(_ lat: Double, long: Double, completion: @escaping (_ result: City?) -> Void) {
        let url = NetworkController.searchWeatherByLocation(lat, lon: long)
        
        NetworkController.dataAtUrl(url) { (resultData) in
            guard let resultData = resultData else {
                print("NO DATA RETURNED")
                completion(nil)
                return
            }
            
            do {
                let weatherAnyObject = try JSONSerialization.jsonObject(with: resultData, options: .allowFragments)
                
                var weatherModelObject: City?
                
                if let weatherDictionary = weatherAnyObject as? [String:AnyObject] {
                    weatherModelObject = City(jsonDictionary: weatherDictionary)
                }
                
                completion(weatherModelObject)
            } catch {
                completion(nil)
            }
        }
    }
    

    func addCity(city: City) {
        cityArray.append(city)
        saveToPersistantStorage()
    }
    
    
    
    //MARK: NSCoding
    func saveToPersistantStorage() {
        NSKeyedArchiver.archiveRootObject(self.cityArray, toFile: self.filePath(key: kCity))
    }
    
    func loadFromPersistantStorage() {
        guard let unarchivedCities = NSKeyedUnarchiver.unarchiveObject(withFile: self.filePath(key: kCity)) else {return}
        
        self.cityArray = unarchivedCities as! [City]
    }
    
    func filePath(key: String) -> String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .allDomainsMask).first
        
        return (url?.appendingPathComponent(key).path)!
    }
    
}
