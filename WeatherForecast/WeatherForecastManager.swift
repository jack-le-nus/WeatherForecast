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
    func getWeatherForecast (completionHandler: @escaping (WeatherForecast) -> Void) {
        Alamofire.request("http://api.openweathermap.org/data/2.5/forecast?id=524901&APPID=50ae8daf0e0ed49417822836f623b00c").responseObject { (response: DataResponse<WeatherForecast>) in
            switch response.result {
            case .success:
                completionHandler(response.result.value!)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
