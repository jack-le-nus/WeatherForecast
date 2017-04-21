
//
//  ChartDrawer.swift
//  WeatherForecast
//
//  Created by Jack Le on 21/4/17.
//  Copyright © 2017 Jack Le. All rights reserved.
//

import Foundation
import Charts

class CombinedChartDecorator : CombinedChartData {
    var combinedChartData: CombinedChartData = CombinedChartData()
    
    init(decoratedChartData: CombinedChartData) {
        super.init()
        self.combinedChartData = decoratedChartData
    }
    
    func decorate(dataEntries: [[ChartDataEntry]]) -> CombinedChartData {
        return self.combinedChartData
    }
}

class LineChartDecorator : CombinedChartDecorator {
    
    override func decorate(dataEntries: [[ChartDataEntry]]) -> CombinedChartData {
        self.combinedChartData.lineData = generateLineData(lineData: dataEntries)
        return self.combinedChartData
    }
    
    func generateLineData(lineData : [[ChartDataEntry]]) -> LineChartData {
        let d : LineChartData = LineChartData()
        
        for item in lineData {
            let set : LineChartDataSet = LineChartDataSet(values: item, label: "Temperature")
            set.setColor(UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1))
            set.lineWidth = 2.5
            set.setCircleColor(UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1))
            set.circleRadius = 5.0
            set.circleHoleRadius = 2.5
            set.fillColor = UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1)
            set.mode = LineChartDataSet.Mode.cubicBezier
            set.drawValuesEnabled = true
            set.valueFont = UIFont.systemFont(ofSize: 10)
            set.valueTextColor = UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1)
            set.axisDependency = YAxis.AxisDependency.left
            d.addDataSet(set)
        }
        
        return d
        
    }
}

class BarChartDecorator : CombinedChartDecorator {
    override func decorate(dataEntries: [[ChartDataEntry]]) -> CombinedChartData {
        self.combinedChartData.barData = generateBarData(barData: dataEntries)
        return self.combinedChartData
    }
    
    func generateBarData(barData : [[ChartDataEntry]]) -> BarChartData {
        let d : BarChartData = BarChartData()
        let groupSpace: Double = 0.06
        let barSpace: Double = 0.02
        let barWidth: Double = 0.45
        
        for item in barData {
            let set1 : BarChartDataSet = BarChartDataSet(values: item, label: "Humidity")
            set1.setColor(UIColor(red: 60/255, green: 220/255, blue: 78/255, alpha: 1))
            set1.valueTextColor = UIColor(red: 60/255, green: 220/255, blue: 78/255, alpha: 1)
            set1.valueFont = UIFont.systemFont(ofSize:10)
            set1.axisDependency = YAxis.AxisDependency.left
            
            d.addDataSet(set1)
        }
        
        
        d.barWidth = barWidth
        // make this BarData object grouped
        d.groupBars(fromX: 0.0, groupSpace: groupSpace, barSpace: barSpace)
        // start at x = 0
        return d
    }
}
