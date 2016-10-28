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
                guard let cityTemperature = cityInfo.temperatureF, let sunrise = cityInfo.sunrise, let sunset = cityInfo.sunset, let humidity = cityInfo.humidity, let pressure = cityInfo.convertedPressure, let description = cityInfo.weatherDescription, let weatherIcon = cityInfo.icon else {return}
                
                let formattedTemp = String(format: "%0.f", cityTemperature)
                
                self.cityTemperatureLabel.text = "\(formattedTemp)°F"
                self.weatherIconView.image = WeatherIcon.getWeatherIcon(icon: weatherIcon)

                let dateSunrise = self.timeStringFromUnixTime(unixTime: sunrise)
                let dateSunset = self.timeStringFromUnixTime(unixTime: sunset)

                
                self.sunriseLabel.text = "\(dateSunrise)"
                self.sunsetLabel.text = "\(dateSunset)"
                
                let formattedHumidity = String(format: "%0.f", humidity)
                self.humidityLabel.text = "\(formattedHumidity)%"
                
                let formattedPressure = String(format: "%0.f", pressure)
                self.pressureLabel.text = "\(formattedPressure) inHg"
                
                self.descriptionLabel.text = "\(description)"
            }
        }
    }

    
    //MARK: Helper Function
    func timeStringFromUnixTime(unixTime: Double) -> String {
        let date = NSDate(timeIntervalSince1970: unixTime)
        
    	let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: date as Date)
    }


}
