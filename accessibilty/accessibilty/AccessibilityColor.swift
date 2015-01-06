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
    class func lightBlueColor() -> UIColor {
        var color = UIColor(red: 85.0/255.0, green: 170.0/255.0, blue: 246.0/255.0, alpha: 1.0)
        return color
    }
    
    // This is the color used for the title labels
    class func lightBlackColor() -> UIColor {
        var color = UIColor(red: 66.0/255.0, green: 76.0/255.0, blue: 75.0/255.0, alpha: 1.0)
        return color
    }
    
    // This is the color used for the details labels
    class func lightPinkColor() -> UIColor {
        var color = UIColor(red: 255.0/255.0, green: 184.0/255.0, blue: 234.0/255.0, alpha: 1.0)
        return color
    }
    
    // This is the color used behind the enlarged profile view
    class func transparentGrayBackground() -> UIColor {
        var color = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.75)
        return color
    }
}
