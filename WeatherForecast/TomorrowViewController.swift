//
//  TomorrowViewController.swift
//  WeatherForecast
//
//  Created by Jack Le on 21/4/17.
//  Copyright © 2017 Jack Le. All rights reserved.
//

import UIKit
import RealmSwift
import Charts
import CoreLocation

class TomorrowViewController: UIViewController, ChartViewDelegate, IAxisValueFormatter {
    
    let weatherForecastManager : WeatherForecastManager = WeatherForecastManager()
    
    override var nibName: String? {
        get {
            return "TomorrowViewController"
        }
    }
    
    var months : [String] = []
    var lists : [List] = []
    @IBOutlet weak var tomorrowChartView: CombinedChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.decorateChart(chart: self.tomorrowChartView)
        
        tomorrowChartView.delegate = self
        tomorrowChartView.xAxis.valueFormatter = self;
    }
    
    func reloadChartData(weatherResponse : WeatherForecast) {
        let groupList : [[List]] = (weatherResponse.list?.groupBy{ $0.dt_nsdate.string(custom: Constants.DATE_FORMAT) })!
        self.lists = groupList[1]
        self.months = self.lists.map {$0.dt_nsdate.string(custom: Constants.TIME_FORMAT)}
        
        var temperatureData: [ChartDataEntry] = []
        for index in 1...self.months.count {
            temperatureData.append(ChartDataEntry(x: Double(index - 1), y: (self.lists[index - 1].main?.temp!)!))
        }
        
        var humidityData: [ChartDataEntry] = []
        for index in 1...self.months.count {
            humidityData.append(BarChartDataEntry(x: Double(index - 1), y: (Double((self.lists[index - 1].main?.humidity!)!))))
        }
        
        var data : CombinedChartData = CombinedChartData()
        data = LineChartDecorator(decoratedChartData:data).decorate(dataEntries: [temperatureData])
        data = BarChartDecorator(decoratedChartData:data).decorate(dataEntries: [humidityData])
        
        self.tomorrowChartView.xAxis.axisMaximum = data.xMax+0.25
        self.tomorrowChartView.data = data
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Tomorrow"
        if WeatherForecastManager.sharedInstance.weatherForeCast != nil {
            reloadChartData(weatherResponse: WeatherForecastManager.sharedInstance.weatherForeCast!)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if (months.count == 0 || value < 0 ){
            return ""
        }
        return months[Int(value)%months.count]
    }
}
