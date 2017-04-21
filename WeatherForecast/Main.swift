//
//  WeatherForecast.swift
//  WeatherForecast
//
//  Created by Jack Le on 21/4/17.
//  Copyright © 2017 Jack Le. All rights reserved.
//

import Foundation
import ObjectMapper

public class Main : Mappable {
	public var temp : Double?
	public var temp_min : Double?
	public var temp_max : Double?
	public var pressure : Double?
	public var sea_level : Double?
	public var grnd_level : Double?
	public var humidity : Int?
	public var temp_kf : Double?
    
    required public init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        temp <- map["temp"]
        temp_min <- map["temp_min"]
        temp_max <- map["temp_max"]
        pressure <- map["pressure"]
        grnd_level <- map["grnd_level"]
        sea_level <- map["sea_level"]
        humidity <- map["humidity"]
        temp_kf <- map["temp_kf"]
    }

}
