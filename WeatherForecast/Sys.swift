//
//  WeatherForecast.swift
//  WeatherForecast
//
//  Created by Jack Le on 21/4/17.
//  Copyright © 2017 Jack Le. All rights reserved.
//

import Foundation
import ObjectMapper


public class Sys : Mappable {
	public var pod : String?

    required public init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        pod <- map["pod"]
    }
}
