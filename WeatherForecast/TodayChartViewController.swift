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
    let ITEM_COUNT = 12
    var months : [String] = []
    var lists : [List] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Combined Chart"
        
        todayChart.delegate = self
        todayChart.chartDescription?.enabled = false
        todayChart.drawGridBackgroundEnabled = false
        todayChart.drawBarShadowEnabled = false
        todayChart.highlightFullBarEnabled = false
        todayChart.drawOrder = [CombinedChartView.DrawOrder.bar.rawValue,CombinedChartView.DrawOrder.bubble.rawValue,CombinedChartView.DrawOrder.candle.rawValue,CombinedChartView.DrawOrder.line.rawValue,CombinedChartView.DrawOrder.scatter.rawValue]
        
        
        let l : Legend = todayChart.legend;
        l.wordWrapEnabled = true
        l.horizontalAlignment = Legend.HorizontalAlignment.center
        l.verticalAlignment = Legend.VerticalAlignment.bottom
        l.orientation = Legend.Orientation.horizontal
        l.drawInside = false
        
        
        let rightAxis : YAxis = todayChart.rightAxis;
        rightAxis.drawGridLinesEnabled = false
        rightAxis.axisMinimum = 0.0
        
        
        let leftAxis : YAxis = todayChart.leftAxis;
        leftAxis.drawGridLinesEnabled = false
        leftAxis.axisMinimum = 0.0
        
        
        let xAxis : XAxis = todayChart.xAxis;
        xAxis.labelPosition = XAxis.LabelPosition.bothSided
        xAxis.axisMinimum = 0.0;
        xAxis.granularity = 1.0;
        xAxis.valueFormatter = self;
        
        var weatherForecastManager : WeatherForecastManager = WeatherForecastManager()
        weatherForecastManager.getWeatherForecast(completionHandler: { (weatherResponse) in
            
            let groupList : [[List]] = weatherResponse.list?.groupBy{ $0.dt_nsdate.string(custom: Constants.DATE_FORMAT) } as! [[List]]
            self.lists = groupList[0]
            self.months = self.lists.map {$0.dt_nsdate.string(custom: Constants.TIME_FORMAT)}
            
            var temperatureData: [ChartDataEntry] = []
            for index in 1...self.months.count {
                temperatureData.append(ChartDataEntry(x: Double(index - 1), y: (self.lists[index - 1].main?.temp_kf!)!))
            }
            
            var humidityData: [ChartDataEntry] = []
            for index in 1...self.months.count {
                humidityData.append(BarChartDataEntry(x: Double(index - 1), y: (Double((self.lists[index - 1].main?.humidity!)!))))
            }
            
            var data : CombinedChartData = CombinedChartData()
            data = LineChartDecorator(decoratedChartData:data).decorate(dataEntries: temperatureData)
            data = BarChartDecorator(decoratedChartData:data).decorate(dataEntries: humidityData)
            
            self.todayChart.xAxis.axisMaximum = data.xMax+0.25
            self.todayChart.data = data
        
        })
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

    func updateChartWithData() {
        
    }

}
