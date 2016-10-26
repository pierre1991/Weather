//
//  CityTableViewCell.swift
//  Weather
//
//  Created by Pierre on 10/10/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    //MARK: Properties
    class var defaultHeight: CGFloat {
        get {
            return 46
        }
    }
    
    class var expandedHeight: CGFloat {
        get {
            return 220
        }
    }
    
    var isExpanded = false
    
    
    //MARK: IBOutlets
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityTemperatureLabel: UILabel!
    
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!

    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var weatherIconView: UIImageView!
    
    
    //MARK: View
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    //MARK: Update
    func update(city: City) {
        cityLabel.text = city.cityName
        
        guard let cityName = city.cityName else {return}
        
        WeatherController.getWeatherForCity(cityName) { (cityInfo) in
            guard let cityInfo = cityInfo else {return}
            
            DispatchQueue.main.async {
                guard let cityTemperature = cityInfo.temperatureF, let sunrise = cityInfo.sunrise, let sunset = cityInfo.sunset, let humidity = cityInfo.humidity, let pressure = cityInfo.pressure, let description = cityInfo.weatherDescription, let weatherIcon = cityInfo.icon else {return}
                
                self.cityTemperatureLabel.text = "\(cityTemperature)"
                self.weatherIconView.image = WeatherIcon.getWeatherIcon(icon: weatherIcon)
                self.sunriseLabel.text = "\(sunrise)"
                self.sunsetLabel.text = "\(sunset)"
                self.humidityLabel.text = "\(humidity)"
                self.pressureLabel.text = "\(pressure)"
                self.descriptionLabel.text = "\(description)"
            }
        }
    }

    
    

    
}
