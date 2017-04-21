//
//  WeatherForecastManager.swift
//  WeatherForecast
//
//  Created by Jack Le on 21/4/17.
//  Copyright © 2017 Jack Le. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class WeatherForecastManager {
    static let sharedInstance = WeatherForecastManager()
    public var weatherForeCast : WeatherForecast? = nil
    func getWeatherForecast ( lat : Double,  lon : Double, completionHandler: @escaping (WeatherForecast) -> Void) {
        let url : String = "http://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&APPID=50ae8daf0e0ed49417822836f623b00c"
        Alamofire.request(url).responseObject { (response: DataResponse<WeatherForecast>) in
            switch response.result {
            case .success:
                self.weatherForeCast = response.result.value!
                completionHandler(self.weatherForeCast!)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
