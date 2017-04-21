//
//  WeatherForecast.swift
//  WeatherForecast
//
//  Created by Jack Le on 21/4/17.
//  Copyright © 2017 Jack Le. All rights reserved.
//

import Foundation
import ObjectMapper


public class Wind : Mappable {
	public var speed : Double?
	public var deg : Double?
    
    required public init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        speed <- map["speed"]
        deg <- map["deg"]
    }
}
