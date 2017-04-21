//
//  WeatherForecast.swift
//  WeatherForecast
//
//  Created by Jack Le on 21/4/17.
//  Copyright © 2017 Jack Le. All rights reserved.
//

import Foundation
import ObjectMapper


public class Weather : Mappable {
	public var id : Int?
	public var main : String?
	public var description : String?
	public var icon : String?
    
    required public init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        id <- map["id"]
        main <- map["main"]
        description <- map["description"]
        icon <- map["icon"]
    }
}
