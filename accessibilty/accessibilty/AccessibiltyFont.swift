//
//  AccessibiltyFont.swift
//  accessibilty
//
//  Created by Steven Beyers on 1/5/15.
//  Copyright (c) 2015 beyerss. All rights reserved.
//

import UIKit

/*
* This extension is used to create our own UIFonts in a re-usable way
*/
extension UIFont {
    
    // This is the font that gets used for screen titles
    class func screenHeaderFont() -> UIFont {
        var font = UIFont(name: "Optima", size: 30.0)
        return font!
    }
    
    // This is the font that gets used for header labels
    class func headerLabelFont() -> UIFont {
        var font = UIFont(name: "Optima", size: 17.0)
        return font!
    }
    
    // This is the font that gets used for details labels
    class func detailLabelFont() -> UIFont {
        var font = UIFont(name: "Optima", size: 13.0)
        return font!
    }
}