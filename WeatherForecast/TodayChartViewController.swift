//
//  TodayChartViewController.swift
//  WeatherForecast
//
//  Created by Jack Le on 20/4/17.
//  Copyright © 2017 Jack Le. All rights reserved.
//

import UIKit
import RealmSwift
import Charts

class TodayChartViewController: UIViewController, ChartViewDelegate, IAxisValueFormatter {

    override var nibName: String? {
        get {
            return "TodayChartViewController"
        }
    }
    
    @IBOutlet weak var todayChart: CombinedChartView!

    var months : [String] = []
    var lists : [List] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.decoratePage()
        self.decorateChart(chart: self.todayChart)
        
        todayChart.delegate = self
        todayChart.xAxis.valueFormatter = self;
        
        let weatherForecastManager : WeatherForecastManager = WeatherForecastManager()
        weatherForecastManager.getWeatherForecast(completionHandler: { (weatherResponse) in
            
            let groupList : [[List]] = (weatherResponse.list?.groupBy{ $0.dt_nsdate.string(custom: Constants.DATE_FORMAT) })!
            self.lists = groupList[0]
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
            
            self.todayChart.xAxis.axisMaximum = data.xMax+0.25
            self.todayChart.data = data
        
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Today";
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
