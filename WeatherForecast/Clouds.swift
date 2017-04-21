//
//  WeatherForecast.swift
//  WeatherForecast
//
//  Created by Jack Le on 21/4/17.
//  Copyright © 2017 Jack Le. All rights reserved.
//

import Foundation
import ObjectMapper


public class Clouds : Mappable {
	public var all : Int?
    
    required public init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        all <- map["all"]
        
    }

}
