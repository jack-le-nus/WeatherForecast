//
//  WeatherForecast.swift
//  WeatherForecast
//
//  Created by Jack Le on 21/4/17.
//  Copyright © 2017 Jack Le. All rights reserved.
//

import Foundation
import ObjectMapper


public class Coord : Mappable {
	public var lat : Double?
	public var lon : Double?
    
    required public init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        lat <- map["lat"]
        lon <- map["lon"]
    }

}
