//
//  ViewController.swift
//  Flo
//
//  Created by Viktor Chernykh on 25.07.2020.
//  Copyright © 2020 Viktor Chernykh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Counter outlets
    @IBOutlet weak var counterView: CounterView!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var graphView: GraphView!
    
    // Label outlets
    @IBOutlet weak var averageWaterDrunk: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    var isGraphViewShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        counterLabel.text = String(counterView.counter)
    }
    
    func setupGraphDisplay() {
        let maxDayIndex = stackView.arrangedSubviews.count - 1
        
        // 1 - Replace last day with today's actual data
        graphView.graphPoints[graphView.graphPoints.count - 1] = counterView.counter
        // 2 - Indicate that the graph needs to be redrawn
        graphView.setNeedsDisplay()
        maxLabel.text = "\(graphView.graphPoints.max() ?? 0)"
        
        // 3 - Calculate average from graphPoints
        let average = graphView.graphPoints.reduce(0, +) / graphView.graphPoints.count
        averageWaterDrunk.text = "\(average)"
        
        // 4 - Setup date formatter and calendar
        let today = Date()
        let calendar = Calendar.current
        
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("EEEEE")
        
        // 5 - Set up the day name labels with correct days
        for i in 0...maxDayIndex {
            if let date = calendar.date(byAdding: .day, value: -i, to: today),
                let label = stackView.arrangedSubviews[maxDayIndex - i] as? UILabel {
                label.text = formatter.string(from: date)
            }
        }
/*
    1. Set today's data as the last item in the graph's data array.
    2. Redraw the graph to account for any changes to today's data.
    3. Use Swift's reduce to calculate the average glasses drunk for the week; it's a very useful method for summing all the elements in an array.
    4. This section sets up DateFormatter to return the first letter of each day.
    5. This loop goes through all labels inside stackView. From this, you set text for each label from date formatter.
*/
    }
    
    
    @IBAction func pushButtonPressed(_ button: PushButton) {
        if button.isAddButton {
            if counterView.counter < 8 {
                counterView.counter += 1
            }
        } else {
            if counterView.counter > 0 {
                counterView.counter -= 1
            }
        }
        counterLabel.text = String(counterView.counter)
        
        if isGraphViewShowing {
            counterViewTap(nil)
        }
    }
    
    @IBAction func counterViewTap(_ gesture: UITapGestureRecognizer?) {
        // Hide Graph
        if isGraphViewShowing {
            UIView.transition(
                from: graphView,
                to: counterView,
                duration: 1.0,
                options: [.transitionFlipFromLeft, .showHideTransitionViews],
                completion: nil
            )
        } else {
            // Show Graph
            setupGraphDisplay()
            UIView.transition(
                from: counterView,
                to: graphView,
                duration: 1.0,
                options: [.transitionFlipFromRight, .showHideTransitionViews],
                completion: nil
            )
        }
        isGraphViewShowing.toggle()
    }
}

