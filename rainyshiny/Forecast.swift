//
//  Forecast.swift
//  rainyshiny
//
//  Created by Ammad on 02/03/2017.
//  Copyright © 2017 Ammad. All rights reserved.
//

import UIKit
import Alamofire

class Forecast{
    
    var _date: String!
    var _weathertType: String!
    var _lowTemp: String!
    var _highTemp: String!
    
    var date: String{
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weatherType: String {
        if _weathertType == nil {
            _weathertType = ""
        }
        return _weathertType
    }
    
    var lowTemp: String {
        if _lowTemp == nil {
            _lowTemp = ""
        }
        return _lowTemp
    }
    
    var highTemp: String {
        if _highTemp == nil {
            _highTemp = ""
        }
        return _highTemp
    }
    
    init(weatherDict: Dictionary<String, AnyObject>)
    {
        
        if let temp = weatherDict["temp"] as? Dictionary< String, AnyObject>
        {
            if let min = temp["min"] as? Double
                {
                let kelvinToFarenhietPreDivision = (min * (9/5)-459.67)
                let kelvintofarenhiet = Double(round(10 * kelvinToFarenhietPreDivision/10))
                
                self._lowTemp = "\(kelvintofarenhiet)"
                }
                if let max = temp["max"] as? Double
                {
                    let kelvinToFarenhietPreDivision = (max * (9/5)-459.67)
                    let kelvintofarenhiet = Double(round(10 * kelvinToFarenhietPreDivision/10))
                    
                    self._highTemp = "\(kelvintofarenhiet)"
                }
        }
        
            if let weather = weatherDict["weather"] as? [Dictionary<String,AnyObject>]
            {
                if let weathertype = weather[0]["main"] as? String
                {
                    self._weathertType = weathertype
                }
            }
        
        if let date = weatherDict["dt"] as? Double {
            let unixConverterdDate = Date(timeIntervalSince1970: date)
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .full
            dateformatter.dateFormat = "EEEE"
            dateformatter.timeStyle = .none
            self._date = unixConverterdDate.dayOfTheWeek()
        }
    }
    
    
}


extension Date {
    func dayOfTheWeek() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "EEEE"
        return dateformatter.string(from: self)
    }
}





