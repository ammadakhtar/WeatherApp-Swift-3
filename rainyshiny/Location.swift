//
//  Location.swift
//  rainyshiny
//
//  Created by Ammad on 07/03/2017.
//  Copyright © 2017 Ammad. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedinstance = Location()
    private init () {}
    var latitude: Double!
    var lontitude: Double!
}
