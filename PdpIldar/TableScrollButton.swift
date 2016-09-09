//
//  TableScrollButton.swift
//  PdpIldar
//
//  Created by Ildar Zalyalov on 09.09.16.
//  Copyright © 2016 com.flatstack. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class TableScrollButton: UIButton {
    
    @IBInspectable var fillColor: UIColor = UIColor.greenColor()
    @IBInspectable var isUpButton: Bool = true
    @IBInspectable var stroksHeight: CGFloat = 3.0
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let path = UIBezierPath(ovalInRect: rect)
        fillColor.setFill()
        path.fill()
        
        //set up the width and height variables
        //for the horizontal stroke
        let horizondalLineHeight: CGFloat = stroksHeight
        let horizondalLineWidth: CGFloat = min(bounds.width/2, bounds.height) * 0.6
        
        //create the path
        let horizondalLine = UIBezierPath()
        
        //set the path's line width to the height of the stroke
        horizondalLine.lineWidth = horizondalLineHeight
        
        //move the initial point of the path
        //to the start of the horizontal stroke
        horizondalLine.moveToPoint(CGPoint(
            x:bounds.width/2 - horizondalLineWidth/2 + 0.5,
            y:bounds.height/2 + 0.5))
        
        //add a point to the path at the end of the stroke
        horizondalLine.addLineToPoint(CGPoint(
            x:bounds.width/2 + horizondalLineWidth/2 + 0.5,
            y:bounds.height/2 + 0.5))
        
        //set the stroke color
        UIColor.whiteColor().setStroke()
        
        //draw the stroke
        horizondalLine.stroke()
        
        if isUpButton{
            let verticalLine = UIBezierPath()
            verticalLine.lineWidth = horizondalLineWidth
            verticalLine.moveToPoint(CGPointMake(bounds.height / 2 - horizondalLineHeight/2 + 0.5, bounds.width/2 + 0.5))
            verticalLine.addLineToPoint(CGPointMake(bounds.height/2 + horizondalLineHeight/2 + 0.5, bounds.width/2 + 0.5))
            UIColor.whiteColor().setStroke()
            
            verticalLine.stroke()
        }
        
        //add shadow
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSizeZero
        layer.shadowRadius = 5
        layer.shouldRasterize = true
    }
    
    
}