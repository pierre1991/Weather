//
//  CityTableViewCell.swift
//  Weather
//
//  Created by Pierre on 10/10/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    
    //MARK: IBOutlets
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityTemperatureLabel: UILabel!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    //MARK: Update
    func update(city: City) {
        cityLabel.text = city.cityName
        
        for city in WeatherController.sharedController.cityArray {
            WeatherController.getWeatherForCity(city.cityName!, completion: { (resultWeather) in
                guard let resultWeather = resultWeather else {return}
                
                print(resultWeather)
            })
        }
        
        cityTemperatureLabel.text = String(format: "\(city.temperatureF)°", "%0.f")
	}

    
}
