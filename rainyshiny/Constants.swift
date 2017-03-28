//
//  Constants.swift
//  rainyshiny
//
//  Created by Ammad on 28/02/2017.
//  Copyright © 2017 Ammad. All rights reserved.
//

import Foundation

let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedinstance.latitude!)&lon=\(Location.sharedinstance.lontitude!)&appid=1c9d238bcad2350cb26c693188159e2a"
let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedinstance.latitude!)&lon=\(Location.sharedinstance.lontitude!)&cnt=10&appid=1c9d238bcad2350cb26c693188159e2a"

typealias DownloadComplete = () -> ()
