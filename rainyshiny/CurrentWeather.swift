//
//  CurrentWeather.swift
//  rainyshiny
//
//  Created by Ammad on 28/02/2017.
//  Copyright © 2017 Ammad. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!

    
    
    var cityName: String
    {
        if _cityName == nil
        {
            _cityName = ""
        }
        return _cityName
    }
    
    var weatherType: String
    {
        if _weatherType == nil
        {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }

    var date : String {
        if _date == nil {
            _date = ""
        }
        let dateformatter =  DateFormatter()
        dateformatter.dateStyle = .long
        dateformatter.timeStyle = .none
        let currentDate = dateformatter.string(from: Date())
        self._date = "Today is,\(currentDate)"
        return _date
    }

    func downloadWeatherDetails(completed: @escaping DownloadComplete){
       
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON { response in
            let result = response
            print(response)
                
            if let dict = result.value as? Dictionary <String, AnyObject>
               {
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                    print(self._cityName)
                }
            
                if let weathertype = dict["weather"] as? [Dictionary<String, AnyObject>]
                {
                    if let main = weathertype[0]["main"] as? String
                    {
                        self._weatherType = main.capitalized
                        print(self._weatherType)
                    }
                    
                }
             
                if let temp = dict["main"] as? Dictionary <String ,AnyObject> {
                    if let currenttemp = temp["temp"] as? Double {
                      
                    let kelvinToFarenhietPreDivision = (currenttemp * (9/5)-459.67)
                    let kelvintofarenhiet = Double(round(10 * kelvinToFarenhietPreDivision/10))
                        
                        self._currentTemp = kelvintofarenhiet
                        print(self._currentTemp)
                    }
                }
            
            
            }
            completed()
        }
        
        
    }

}
