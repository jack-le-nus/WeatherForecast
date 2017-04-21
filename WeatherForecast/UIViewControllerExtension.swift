//
//  UIViewControllerExtension.swift
//  WeatherForecast
//
//  Created by Jack Le on 21/4/17.
//  Copyright © 2017 Jack Le. All rights reserved.
//

import Foundation
import Charts

extension UIViewController {
    func decorateChart(chart : CombinedChartView) {
        chart.chartDescription?.enabled = false
        chart.drawGridBackgroundEnabled = false
        chart.drawBarShadowEnabled = false
        chart.highlightFullBarEnabled = false
        chart.drawOrder = [CombinedChartView.DrawOrder.bar.rawValue,CombinedChartView.DrawOrder.bubble.rawValue,CombinedChartView.DrawOrder.candle.rawValue,CombinedChartView.DrawOrder.line.rawValue,CombinedChartView.DrawOrder.scatter.rawValue]
        
        
        let l : Legend = chart.legend;
        l.wordWrapEnabled = true
        l.horizontalAlignment = Legend.HorizontalAlignment.center
        l.verticalAlignment = Legend.VerticalAlignment.bottom
        l.orientation = Legend.Orientation.horizontal
        l.drawInside = false
        
        
        let rightAxis : YAxis = chart.rightAxis;
        rightAxis.drawGridLinesEnabled = false
        rightAxis.axisMinimum = 0.0
        
        
        let leftAxis : YAxis = chart.leftAxis;
        leftAxis.drawGridLinesEnabled = false
        leftAxis.axisMinimum = 0.0
        
        
        let xAxis : XAxis = chart.xAxis;
        xAxis.labelPosition = XAxis.LabelPosition.bothSided
        xAxis.axisMinimum = 0.0;
        xAxis.granularity = 1.0;
    }
    
    func openMap() {
        self.performSegue(withIdentifier: "showMap", sender: nil)
    }
    
    func decoratePage() {
        let navigationBar = navigationController?.navigationBar
        navigationBar?.barTintColor = UIColor(red: 17.0/255, green: 148.0/255, blue: 250.0/255, alpha: 1.0)
        navigationBar?.barStyle = UIBarStyle.blackTranslucent
        
        let rightButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: nil)
        rightButton.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = rightButton
        self.navigationController?.navigationBar.items = [navigationItem]
    }
}
