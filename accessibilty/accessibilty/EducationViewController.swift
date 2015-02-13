//
//  EducationViewController.swift
//  accessibilty
//
//  Created by Steven Beyers on 2/13/15.
//  Copyright (c) 2015 beyerss. All rights reserved.
//

import UIKit

class EducationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var educationTableView: UITableView!
    var graduationDate: NSDate?
    var dateFormatter: NSDateFormatter?
    var cellDateFormatter: NSDateFormatter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // create the starting date and the date formatter to create strings
        // from the date
        var firstGradDateString = "6/14/03"
        dateFormatter = NSDateFormatter()
        dateFormatter?.dateFormat = "MM/dd/yy"
        graduationDate = dateFormatter?.dateFromString(firstGradDateString)
        
        // Creating a date formatter that will be given to each cell. I'm doing
        // this here so that the expensive date formatter is only created once
        // instead of a new one being created for every cell.
        cellDateFormatter = NSDateFormatter()
        cellDateFormatter?.dateStyle = NSDateFormatterStyle.MediumStyle
        cellDateFormatter?.timeStyle = NSDateFormatterStyle.NoStyle
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("basicCell") as? UITableViewCell
        
        if let educationCell = cell as? EducationTableViewCell {
            educationCell.dateFormatter = cellDateFormatter
            
            educationCell.educationInstitutionLabel.text = "Institution \(indexPath.row + 1)"
            educationCell.degreeTypeLabel.text = "Bachelor of Science"
            
            // some math to make sure all graduation dates are not the same
            //
            // The first cell will be 6/14/03 and every cell after will have a 
            // date that is one day later
            var gradDate = graduationDate?.dateByAddingTimeInterval(NSTimeInterval((60 * 60 * 24) * indexPath.row))
            educationCell.date = gradDate
            var dateString = dateFormatter?.stringFromDate(gradDate!)
            if let date = dateString {
                educationCell.gradDateLabel.text = "Grad Date: \(date)"
            }
            
            // Tell the cell to figure out what it wants to say
            educationCell.updateAccessibility()
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 500
    }
}
