//
//  CityListViewController.swift
//  Weather
//
//  Created by Pierre on 9/29/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import UIKit

class CityListViewController: UIViewController {


    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noCityView: UIView!
    
    
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    
    //MARK: IBActions

}

extension CityListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if WeatherController.sharedController.cityArray.count == 0 {
            noCityView.isHidden = false
        } else if WeatherController.sharedController.cityArray.count > 0 {
            noCityView.isHidden = true
        }
        
        return WeatherController.sharedController.cityArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityTableViewCell
        let city = WeatherController.sharedController.cityArray[indexPath.row]
        
        cell.update(city: city)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            WeatherController.sharedController.cityArray.remove(at: indexPath.row)
            WeatherController.sharedController.saveToPersistantStorage()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
