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
    
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
    }
    
    
    //MARK: IBActions
    @IBAction func dismissViewButtonTapped(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}

extension CityListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WeatherController.sharedController.cityArray.uniq().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        let city = WeatherController.sharedController.cityArray[indexPath.row]
        
        cell.textLabel?.text = city.cityName
        
        return cell
    }
    
    
}
