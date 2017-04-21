//
//  WeatherForecast.swift
//  WeatherForecast
//
//  Created by Jack Le on 21/4/17.
//  Copyright © 2017 Jack Le. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftDate

public class List : Mappable {
	public var dt : Int?
	public var main : Main?
	public var weather : Array<Weather>?
	public var clouds : Clouds?
	public var wind : Wind?
	public var snow : Snow?
	public var sys : Sys?
	public var dt_txt : String?
    public var dt_nsdate : DateInRegion = DateInRegion()
    
    required public init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        dt <- map["dt"]
        main <- map["main"]
        weather <- map["weather"]
        clouds <- map["clouds"]
        wind <- map["wind"]
        snow <- map["snow"]
        sys <- map["sys"]
        dt_txt <- map["dt_txt"]
        
        var dateTransformer : DataTransformer = DataTransformer()
        dt_nsdate = dateTransformer.timeStringToDate(timeString: dt_txt!, formatString: Constants.DATE_TIME_FORMAT)!
        
    }

}
