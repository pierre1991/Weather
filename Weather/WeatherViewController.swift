//
//  WeatherViewController.swift
//  Weather
//
//  Created by Pierre on 7/6/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate {

    //MARK: Properties
    var city: City?
    
    let locationManager = CLLocationManager()
    var locationLat: Double = 0
    var locationLong: Double = 0
    
    
    
    //MARK: IBOutlets
    @IBOutlet weak var weatherLogo: UIImageView!
    @IBOutlet weak var initialLabel: UILabel!
    
    @IBOutlet weak var searchField: UITextField!
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var searchButton: UIButton!

    @IBOutlet weak var addCityButton: UIButton!

    
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupOffscreenViews()
        
        searchField.keyboardAppearance = .dark
        
        
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
            print(locationLat)
            print(locationLong)
        }
	}
    
    
    //MARK: Touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchField.resignFirstResponder()
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationValue: CLLocationCoordinate2D = (manager.location?.coordinate)!
        locationLat = locationValue.latitude
        locationLong = locationValue.longitude
    }
    
    
    
    
    //MARK: IBActions
    @IBAction func searchBarButtonTapped(_ sender: AnyObject) {
        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.4, options: .curveEaseOut, animations: { 
                    self.initialLabel.layer.transform = CATransform3DTranslate(CATransform3DIdentity, +self.view.frame.width, 0, 0)
            }, completion: nil)

        setupOnscreenViews()
    }
    
    
    
    
    @IBAction func searchButtonTapped(_ sender: AnyObject) {
		if let text = searchField.text {
            WeatherController.getWeatherForCity(text, completion: { (result) in
                guard let weatherResult = result else {return}
                
                self.city = weatherResult
                
    			DispatchQueue.main.async(execute: {
                    self.cityName.text = weatherResult.cityName
                    
                    if let temperatureC = weatherResult.temperatureC {
                        self.temperatureLabel.text = String(temperatureC) + " C"
                    }
                    
                    self.descriptionLabel.text = weatherResult.description
                    
                    
                    self.weatherLogo.layer.transform = CATransform3DTranslate(CATransform3DIdentity, +self.view.frame.width, 0, 0)
                    self.searchField.layer.transform = CATransform3DTranslate(CATransform3DIdentity, +self.view.frame.width, 0, 0)
                    self.searchButton.layer.transform = CATransform3DTranslate(CATransform3DIdentity, +self.view.frame.width, 0, 0)
                    
                    UIView.animate(withDuration: 1.0, animations: { 
                        self.cityName.layer.transform = CATransform3DIdentity
                        self.temperatureLabel.layer.transform = CATransform3DIdentity
                        self.descriptionLabel.layer.transform = CATransform3DIdentity
                        
                        self.addCityButton.layer.transform = CATransform3DIdentity
                    })
                })
            })
        }
    }
    
    
    @IBAction func cityListButtonTapped(_ sender: AnyObject) {
        performSegue(withIdentifier: "toCityView", sender: self)
    }
    
    
    @IBAction func addCityButtonTapped(_ sender: AnyObject) {
        guard let city = self.city else {return}
        
        WeatherController.sharedController.addCity(city: city)
    }
    
    

    
    
    
    
    
    
    //Removes Weather search views and search views off screen
    func setupOffscreenViews() {
        cityName.layer.transform = CATransform3DTranslate(CATransform3DIdentity, -self.view.frame.width, 0, 0)
        temperatureLabel.layer.transform = CATransform3DTranslate(CATransform3DIdentity, -self.view.frame.width, 0, 0)
        descriptionLabel.layer.transform = CATransform3DTranslate(CATransform3DIdentity, -self.view.frame.width, 0, 0)
        
        searchField.layer.transform = CATransform3DTranslate(CATransform3DIdentity, -self.view.frame.width, 0, 0)
        searchButton.layer.transform = CATransform3DTranslate(CATransform3DIdentity, -self.view.frame.width, 0, 0)
        
        addCityButton.layer.transform = CATransform3DTranslate(CATransform3DIdentity, 0, +self.view.frame.height, 0)
    }
    
    
    
    
    
    //Moves searchField and searchButton onto the view
    func setupOnscreenViews() {
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: .curveEaseIn, animations: { 
            self.searchField.layer.transform = CATransform3DIdentity
            }, completion: nil)
        
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: .curveEaseIn, animations: {
            self.searchButton.layer.transform = CATransform3DIdentity
            }, completion: nil)
    }
    
    
}
