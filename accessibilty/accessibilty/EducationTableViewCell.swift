//
//  EducationTableViewCell.swift
//  accessibilty
//
//  Created by Steven Beyers on 2/13/15.
//  Copyright (c) 2015 beyerss. All rights reserved.
//

import UIKit

class EducationTableViewCell: UITableViewCell {

    @IBOutlet weak var educationInstitutionLabel: UILabel!
    @IBOutlet weak var degreeTypeLabel: UILabel!
    @IBOutlet weak var gradDateLabel: UILabel!
    
    var dateFormatter: NSDateFormatter?
    var date: NSDate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateAccessibility() {
        var dateString = dateFormatter?.stringFromDate(date!)
        if let institution = educationInstitutionLabel.text {
            if let degree = degreeTypeLabel.text {
                if let readableDate = dateString {
                    // Note that Siri does understand punctuation so the "." and "," characters will help in making Siri read it the way we want her to.
                    self.accessibilityLabel = "\(institution). \(degree). Graduation date, \(readableDate)"
                }
            }
        }
    }

}
