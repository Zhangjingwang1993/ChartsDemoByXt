//
//  ViewController.swift
//  Charts-Swift
//
//  Created by zjwang on 16/4/26.
//  Copyright © 2016年 夏天. All rights reserved.
//

import UIKit
import Charts
/// 使用Cocoapods安装
/// use_frameworks!
/// pod 'Charts'
let screenWidth = UIScreen.mainScreen().bounds.width
let screenHeight = UIScreen.mainScreen().bounds.height

class ViewController: UIViewController, ChartViewDelegate {
    var chartView = BarChartView()
    // 柱状图横坐标
    let months = [
    "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep",
    "Oct", "Nov", "Dec"
    ]
    // 柱状的高度值
    let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.createLineChartView()
        self.setChart(months, values: unitsSold)
        self.createRightBarButtonItem()
    }
    // 创建保存按钮
    func createRightBarButtonItem()
    {
        let buttonRight = UIButton.init(type: UIButtonType.Custom)
        buttonRight.frame = CGRectMake(0, 0, 40, 40)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: buttonRight)
        buttonRight.setTitle("Save", forState: UIControlState.Normal)
        buttonRight.addTarget(self, action:#selector(ViewController.save(_:)), forControlEvents: UIControlEvents.TouchUpInside)
    }
    func save(btn: UIButton)
    {
        // 保存到相册
        chartView.saveToCameraRoll()
        print("保存成功")
    }

    // 创建柱状图
    func createLineChartView()
    {
        chartView = BarChartView.init(frame: CGRectMake(0, 64, screenWidth, screenHeight - 64))
        chartView.barData
        // 签协议
        chartView.delegate = self
        chartView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(chartView)
    }
    // 加上模拟数据
    func setChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Units Sold")
        let chartData = BarChartData(xVals: months, dataSet: chartDataSet)
        // 加上一个界限, 演示图中红色的线
        let jx = ChartLimitLine(limit: 12.0, label: "I am LimitLine")
        chartView.rightAxis.addLimitLine(jx)
        chartView.data = chartData
        // 自定义颜色
        // 例子中有十二个柱状图
        // colors 是一个数组, 可以给相应的颜色
        chartDataSet.colors = [UIColor.blueColor(), UIColor.redColor(), UIColor.cyanColor()]
        // API 自带颜色模板
        // ChartColorTemplates.liberty()
        // ChartColorTemplates.joyful()
        // ChartColorTemplates.pastel()
        // ChartColorTemplates.colorful()
        // ChartColorTemplates.vordiplom()
        chartDataSet.colors = ChartColorTemplates.liberty()
        /**
         // 动画效果, 简单列举几个, 具体请看API
         case EaseInBack
         case EaseOutBack
         case EaseInOutBack
         case EaseInBounce
         case EaseOutBounce
         case EaseInOutBounce
          */
        chartView.animate(yAxisDuration: 1.0, easingOption: .EaseInBounce)
    }
    // 默认的捏拉缩放和双击来进行缩放, 如果某个柱形条被单击，该柱形条会突出显示
    // 所以单机某个的时候响应不同的事件, 需要自己编写 遵循ChartViewDelegate协议
    // 实现 Delegate
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int,     highlight: ChartHighlight) {
        print("\(entry.value) in \(months[entry.xIndex])")
    }
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

