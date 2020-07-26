//
//  CounterView.swift
//  Flo
//
//  Created by Viktor Chernykh on 25.07.2020.
//  Copyright © 2020 Viktor Chernykh. All rights reserved.
//

import UIKit

@IBDesignable class CounterView: UIView {
    
    private struct Constants {
        static let numberOfGlasses = 8
        static let lineWidth: CGFloat = 2.0
        static let arcWidth: CGFloat = 76
        
        static var halfOfLineWidth: CGFloat {
            return lineWidth / 2
        }
    }
    
    @IBInspectable var counter: Int = 0 {
        didSet {
            if counter <=  Constants.numberOfGlasses {
                //the view needs to be refreshed
                setNeedsDisplay()
            }
        }
    }
    @IBInspectable var outlineColor: UIColor = UIColor.blue
    @IBInspectable var counterColor: UIColor = UIColor.orange
    
    override func draw(_ rect: CGRect) {
        // 1
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        
        // 2
        let radius = max(bounds.width, bounds.height) / 2
        
        // 3
        let startAngle: CGFloat = 3 * .pi / 4
        let endAngle: CGFloat = .pi / 4
        
        // 4
        let path = UIBezierPath(
            arcCenter: center,
            radius: radius - Constants.arcWidth/2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true)

        // 5
        path.lineWidth = Constants.arcWidth
        counterColor.setStroke()
        path.stroke()
        
/*
     1. Define the center point you’ll rotate the arc around.
     2. Calculate the radius based on the maximum dimension of the view.
     3. Define the start and end angles for the arc.
     4. Create a path based on the center point, radius and angles you defined.
     5. Set the line width and color before finally stroking the path.
*/
        //Draw the outline
        
        //1 - first calculate the difference between the two angles
        //ensuring it is positive
        let angleDifference: CGFloat = 2 * .pi - startAngle + endAngle
        //then calculate the arc for each single glass
        let arcLengthPerGlass = angleDifference / CGFloat(Constants.numberOfGlasses)
        //then multiply out by the actual glasses drunk
        let outlineEndAngle = arcLengthPerGlass * CGFloat(counter) + startAngle
        
        //2 - draw the outer arc
        let outerArcRadius = bounds.width/2 - Constants.halfOfLineWidth
        let outlinePath = UIBezierPath(
            arcCenter: center,
            radius: outerArcRadius,
            startAngle: startAngle,
            endAngle: outlineEndAngle,
            clockwise: true)
        
        //3 - draw the inner arc
        let innerArcRadius = bounds.width/2 - Constants.arcWidth
            + Constants.halfOfLineWidth
        
        outlinePath.addArc(
            withCenter: center,
            radius: innerArcRadius,
            startAngle: outlineEndAngle,
            endAngle: startAngle,
            clockwise: false)
        
        //4 - close the path
        outlinePath.close()
        
        outlinePath.lineWidth = Constants.lineWidth
        outlineColor.setStroke()
        outlinePath.stroke()
    }
}
