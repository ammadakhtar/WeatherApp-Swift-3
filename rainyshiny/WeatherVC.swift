//
//  WeatherVC.swift
//  rainyshiny
//
//  Created by Ammad on 27/02/2017.
//  Copyright © 2017 Ammad. All rights reserved.
//

import UIKit
import Alamofire
import  CoreLocation

class WeatherVC: UIViewController , UITableViewDelegate , UITableViewDataSource , CLLocationManagerDelegate {

    @IBOutlet weak var datelabel: UILabel!
    @IBOutlet weak var currenttemplabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherType: UILabel!
    @IBOutlet weak var tableview: UITableView!
    var currentWeather = CurrentWeather()
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    let locationmanager = CLLocationManager()
    var currentlocation : CLLocation!
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        
        locationmanager.delegate = self
        locationmanager.desiredAccuracy = kCLLocationAccuracyBest
        locationmanager.requestWhenInUseAuthorization()
        locationmanager.startMonitoringSignificantLocationChanges()
        
        //forecast = Forecast()
        currentWeather = CurrentWeather()
       
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthorized()
    }
    
    
    func locationAuthorized(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            
        currentlocation = locationmanager.location
           Location.sharedinstance.latitude = currentlocation.coordinate.latitude
           Location.sharedinstance.lontitude = currentlocation.coordinate.longitude
            currentWeather.downloadWeatherDetails {
                
                self.downloadforecastData{
                    self.updateMainUI()
                }
            }
        }
        else {
            locationmanager.requestWhenInUseAuthorization()
            locationAuthorized()
        }
    }
    
    func downloadforecastData(completed : @escaping DownloadComplete) {
        let forecastURL = URL(string: FORECAST_URL)!
        Alamofire.request(forecastURL).responseJSON{response in
            let result = response
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let list = dict["list"] as? [Dictionary<String,AnyObject>] {
                        
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                    }
                    self.forecasts.remove(at: 0)
                    self.tableview.reloadData()
                }
            }
        completed()
        
        }
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell
        {
          
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            
            return cell
        }
        else {
            return WeatherCell()
        }
    }
    
    func updateMainUI() {
        datelabel.text = currentWeather.date
        currenttemplabel.text = "\(currentWeather.currentTemp)"
        print("\(currenttemplabel)" + "hello")
        print("hello")
        currentWeatherType.text = currentWeather.weatherType
        print(currentWeatherType)
        locationLabel.text = currentWeather.cityName
        print(locationLabel)
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
        
    }
}

