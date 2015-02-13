//
//  AccessibilityAgeSlider.swift
//  accessibilty
//
//  Created by Steven Beyers on 2/13/15.
//  Copyright (c) 2015 beyerss. All rights reserved.
//

import UIKit

class AccessibilityAgeSlider: UISlider {

    // Defined in the UIAccessibility Protocol to define
    // what information is given when accessibilty is used
    func accessibilityValue() -> String {
        var age = Int(self.value)
        return "\(age) years old"
    }
    
    // Override this so that we can increment the value by 
    // 1 year at a time. We must always send the Value Changed
    // control event when we change the value
    override func accessibilityIncrement() {
        self.value++
        sendActionsForControlEvents(.ValueChanged)
    }
    
    // Override this so that we can decrement the value by
    // 1 year at a time. We must always send the Value Changed
    // control event when we change the value
    override func accessibilityDecrement() {
        self.value--
        sendActionsForControlEvents(.ValueChanged)
    }
}
