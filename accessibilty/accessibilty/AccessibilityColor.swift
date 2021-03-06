//
//  AccessibilityColor.swift
//  accessibilty
//
//  Created by Steven Beyers on 1/5/15.
//  Copyright (c) 2015 beyerss. All rights reserved.
//

import UIKit

/*
* This extension is used to create our own UIColors in a re-usable way
*/
extension UIColor {
    
    // This is teh color used for the screen title
    // If the darker colors setting is on then I will use the system blue color
    class func lightBlueColor() -> UIColor {
        var color: UIColor?
        
        if (UIAccessibilityDarkerSystemColorsEnabled()) {
            color = UIColor.blueColor()
        } else {
            color = UIColor(red: 85.0/255.0, green: 170.0/255.0, blue: 246.0/255.0, alpha: 1.0)
        }
        
        return color!
    }
    
    // This is the color used for the title labels
    // If the darker colors setting is on then I will use the system black color
    class func lightBlackColor() -> UIColor {
        var color: UIColor?
        
        if (UIAccessibilityDarkerSystemColorsEnabled()) {
            color = UIColor.blackColor()
        } else {
            color = UIColor(red: 66.0/255.0, green: 76.0/255.0, blue: 75.0/255.0, alpha: 1.0)
        }
        
        return color!
    }
    
    // This is the color used for the details labels
    // If the darker colors setting is on then I will use a darker pink
    class func lightPinkColor() -> UIColor {
        var color: UIColor?
        
        if (UIAccessibilityDarkerSystemColorsEnabled()) {
            color = UIColor(red: 255.0/255.0, green: 0.0/255.0, blue: 223.0/255.0, alpha: 1.0)
        } else {
            color = UIColor(red: 255.0/255.0, green: 184.0/255.0, blue: 234.0/255.0, alpha: 1.0)
        }
        
        return color!
    }
    
    // This is the color used behind the enlarged profile view
    // I am not responding to the darker colors option with this method because it is already
    // black. If this should be darker then the reduce transparency option will need to be set.
    class func transparentGrayBackground() -> UIColor {
        var alpha = alphaValue(0.75)
        
        var color = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: alpha)
        return color
    }
    
    // This method will determine if reduced transparency is on. If it is on, this
    // method will return an alpha value of 1 otherwise it will return the desired
    // alpha value
    class func alphaValue(desiredAlpha: CGFloat) -> CGFloat {
        var alpha = desiredAlpha
        if (UIAccessibilityIsReduceTransparencyEnabled()) {
            alpha = 1.0
        }
        
        return alpha
    }
}
