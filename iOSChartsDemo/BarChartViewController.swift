//
//  BarChartViewController.swift
//  iOSChartsDemo
//
//  Created by Joyce Echessa on 6/12/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit
import Charts

class BarChartViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var barChartView: BarChartView!
    
    var months = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        barChartView.noDataTextDescription = "GIVE REASON"
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        setChart(values: unitsSold)
        
        // ChartViewDelegate
        barChartView.delegate = self
    }
    
    func setChart(values: [Double]) {
        barChartView.noDataText = "You need to provide data for the chart"
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<values.count {
            let dataEntry = BarChartDataEntry(x: Double(i), yValues: [values[i]], data: months[i] as AnyObject)
            //let dataEntry = BarChartDataEntry(x: Double(i + 1), y: values[i], data: months[i] as AnyObject)
            //= BarChartDataEntry(value: values[i], xIndex: i)
//            dataEntry.icon = #imageLiteral(resourceName: "icon")
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Units Sold")
        //= BarChartDataSet(yVals: dataEntries, label: "Units Sold")
        let chartData = BarChartData(dataSet: chartDataSet)
        
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values:months) // Converts the months string to format that can be read on the graph
        barChartView.xAxis.granularity = 1
    
        //= BarChartData(xVals: months, dataSet: chartDataSet)
        barChartView.data = chartData
        barChartView.chartDescription?.text = "" // Get rid of description on bottom right side
        
//        chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        chartDataSet.colors = ChartColorTemplates.colorful()
        
//        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
        
        // Add a limit line
        let ll = ChartLimitLine(limit: 10.0, label: "Target")
        barChartView.rightAxis.addLimitLine(ll)
    }
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: Highlight) {
        println("\(entry.value) in \(months[entry.xIndex])")
    }

}

