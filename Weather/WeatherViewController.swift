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
    
    var keyboardHeight: CGFloat!
    
    
    //MARK: IBOutlets
    @IBOutlet weak var weatherLogo: UIImageView!
    @IBOutlet weak var initialLabel: UILabel!
    
    @IBOutlet weak var searchField: UITextField!
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var searchButton: UIButton!

    @IBOutlet weak var addCityButton: UIButton!

    
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupOffscreenViews()
        
        searchField.keyboardAppearance = .dark
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotification), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotification), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        //locationLat = (locationManager.location?.coordinate.latitude)!
        //locationLong = (locationManager.location?.coordinate.longitude)!
    }
    
    
    //MARK: Status Bar
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    
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
    @IBAction func locationButtonTapped(_ sender: AnyObject) {
        locationWeather()
        
        moveLogoView()
        moveSearchViews()
        
        UIView.animate(withDuration: 1.0, animations: {
            self.cityName.layer.transform = CATransform3DIdentity
            self.temperatureLabel.layer.transform = CATransform3DIdentity
            self.weatherIcon.layer.transform = CATransform3DIdentity
            self.descriptionLabel.layer.transform = CATransform3DIdentity
            
            self.addCityButton.layer.transform = CATransform3DIdentity
        })
    }
    
    
    func locationWeather() {
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            
            WeatherController.getWeatherForLocation(locationLat, long: locationLong, completion: { (result) in
                guard let weatherResult = result else {return}
                
                self.city = weatherResult
                
                DispatchQueue.main.sync(execute: {
                    self.cityName.text = weatherResult.cityName
                    
                    if let temperatureF = weatherResult.temperatureF {
                        let formattedTemp = String(format: "%.0f", temperatureF)
                        
                        self.temperatureLabel.text = String("\(formattedTemp)°")
                    }
                    
                    if let weatherIcon = weatherResult.icon {
                        self.weatherIcon.image = WeatherIcon.getWeatherIcon(icon: weatherIcon)
                    }
                    
                    self.descriptionLabel.text = weatherResult.weatherDescription
                })
            })
        }
    }
    
    
    
    @IBAction func searchBarButtonTapped(_ sender: AnyObject) {
        moveLocationViews()
        
        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.4, options: .curveEaseOut, animations: {
                    self.initialLabel.layer.transform = CATransform3DTranslate(CATransform3DIdentity, +self.view.frame.width, 0, 0)
            }, completion: nil)
        
        UIView.animate(withDuration: 0.8, animations: {
            self.addCityButton.layer.transform = CATransform3DTranslate(CATransform3DIdentity, 0, +self.view.frame.height, 0)
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
                    
                    if let temperatureF = weatherResult.temperatureF {
                        let formattedTemp = String(format: "%.0f", temperatureF)
                        self.temperatureLabel.text = String("\(formattedTemp)°")
                    }
                    
                    if let weatherIcon = weatherResult.icon {
                        self.weatherIcon.image = WeatherIcon.getWeatherIcon(icon: weatherIcon)
                    }
                    
                    self.descriptionLabel.text = weatherResult.weatherDescription
                    
                	
                    self.moveSearchViews()
                    
                    UIView.animate(withDuration: 1.0, animations: { 
                        self.cityName.layer.transform = CATransform3DIdentity
                        self.temperatureLabel.layer.transform = CATransform3DIdentity
                        self.weatherIcon.layer.transform = CATransform3DIdentity
                        self.descriptionLabel.layer.transform = CATransform3DIdentity
                        
                        self.addCityButton.layer.transform = CATransform3DIdentity
                    })
                })
            })
        }
    }
    
    
    @IBAction func cityListButtonTapped(_ sender: AnyObject) {
//        if let cityListViewContorller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CityListViewController") as? CityListViewController {
//            present(cityListViewContorller, animated: true, completion: nil)
//        }
    }
    
    
    @IBAction func addCityButtonTapped(_ sender: AnyObject) {
        guard let city = self.city else {return}
        
        WeatherController.sharedController.addCity(city: city)
    }
    
    

    
    //Removes Weather search views and search views off view
    func setupOffscreenViews() {
        cityName.layer.transform = CATransform3DTranslate(CATransform3DIdentity, -self.view.frame.width, 0, 0)
        temperatureLabel.layer.transform = CATransform3DTranslate(CATransform3DIdentity, -self.view.frame.width, 0, 0)
        weatherIcon.layer.transform = CATransform3DTranslate(CATransform3DIdentity, -self.view.frame.width, 0, 0)
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
    
    //Move searchField, searchButton, weatherLogo off view
    func moveLogoView() {
        self.weatherLogo.layer.transform = CATransform3DTranslate(CATransform3DIdentity, +self.view.frame.width, 0, 0)
        self.initialLabel.layer.transform = CATransform3DTranslate(CATransform3DIdentity, +self.view.frame.width, 0, 0)
    }
    
    func moveSearchViews() {
        UIView.animate(withDuration: 0.4) {
            self.searchField.layer.transform = CATransform3DTranslate(CATransform3DIdentity, +self.view.frame.width, 0, 0)
            self.searchButton.layer.transform = CATransform3DTranslate(CATransform3DIdentity, +self.view.frame.width, 0, 0)
        }
    }
    
    func moveLocationViews() {
        cityName.layer.transform = CATransform3DTranslate(CATransform3DIdentity, -self.view.frame.width, 0, 0)
        temperatureLabel.layer.transform = CATransform3DTranslate(CATransform3DIdentity, -self.view.frame.width, 0, 0)
        weatherIcon.layer.transform = CATransform3DTranslate(CATransform3DIdentity, -self.view.frame.width, 0, 0)
        descriptionLabel.layer.transform = CATransform3DTranslate(CATransform3DIdentity, -self.view.frame.width, 0, 0)
    }
    
    
    
    func keyboardNotification(_ notification: Notification) {
        let info: NSDictionary = (notification as NSNotification).userInfo! as NSDictionary
        let value: NSValue = info.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardFrame: CGRect = value.cgRectValue
        let cgFloatKeyboardHeight: CGFloat = keyboardFrame.size.height
        self.keyboardHeight = cgFloatKeyboardHeight
        
        let isKeyboardShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
        
        
        if isKeyboardShowing {
            UIView.animate(withDuration: 2.0, animations: {
                self.weatherLogo.layer.transform = CATransform3DTranslate(CATransform3DIdentity, 0, -self.view.frame.height, 0)
                
                self.searchField.layer.transform = CATransform3DTranslate(CATransform3DIdentity, 0, -((UIScreen.main.bounds.height - self.keyboardHeight) / 2) - (self.searchField.frame.height), 0)
                self.searchButton.layer.transform = CATransform3DTranslate(CATransform3DIdentity, 0, -((UIScreen.main.bounds.height - self.keyboardHeight) / 2) - (self.searchButton.frame.height), 0)
                
            })
        } else {
            UIView.animate(withDuration: 2.0, animations: { 
                self.weatherLogo.layer.transform = CATransform3DIdentity
                self.searchField.layer.transform = CATransform3DIdentity
                self.searchButton.layer.transform = CATransform3DIdentity
            })
        }
    }
    
}
