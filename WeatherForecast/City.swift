//
//  WeatherForecast.swift
//  WeatherForecast
//
//  Created by Jack Le on 21/4/17.
//  Copyright © 2017 Jack Le. All rights reserved.
//

import Foundation
import ObjectMapper

public class City : Mappable {
	public var id : Int?
	public var name : String?
	public var coord : Coord?
	public var country : String?
    
    required public init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        coord <- map["coord"]
        country <- map["country"]
    }
}
