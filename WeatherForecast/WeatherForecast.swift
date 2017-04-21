//
//  WeatherForecast.swift
//  WeatherForecast
//
//  Created by Jack Le on 21/4/17.
//  Copyright © 2017 Jack Le. All rights reserved.
//

import Foundation
import ObjectMapper

class WeatherForecast : Mappable {
    var cod : String?
    var message : Double?
    var cnt : Int?
    var list : [List]?
    var city : City?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        cod <- map["cod"]
        message <- map["message"]
        cnt <- map["cnt"]
        city <- map["city"]
        list <- map["list"]
    }
}
