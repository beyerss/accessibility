//
//  ViewController.swift
//  accessibilty
//
//  Created by Steven Beyers on 1/5/15.
//  Copyright (c) 2015 beyerss. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // outlets from storyboard
    @IBOutlet weak var screenHeader: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var employerHeader: UILabel!
    @IBOutlet weak var employerDetail: UILabel!
    @IBOutlet weak var titleHeader: UILabel!
    @IBOutlet weak var titleDetail: UILabel!
    @IBOutlet weak var biographyHeader: UILabel!
    @IBOutlet weak var biographyDetail: UILabel!
    @IBOutlet weak var ageHeader: UILabel!
    @IBOutlet weak var ageSlider: UISlider!
    @IBOutlet weak var educationButton: UIButton!
    
    // constraints for the large image that is displayed when you tap the profile image
    var topLargeImageConstraint: NSLayoutConstraint?
    var leftLargeImageConstraint: NSLayoutConstraint?
    var heightImageConstraint: NSLayoutConstraint?
    var widthImageConstraint: NSLayoutConstraint?
    // the background view that partially hides the profile while image is enlarged
    var backgroundView: UIView?
    // the image view used to dipslay a larger profile image
    var largeImageView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up fonts
        setupScreenHeaderLabel()
        setupHeaderLabels()
        setupDetailLabels()
        
        view.accessibilityElements = [screenHeader, profileImage, employerHeader, employerDetail, titleHeader, titleDetail, biographyHeader, biographyDetail, ageHeader, ageSlider, educationButton]
    }
    
    // This method sets up the font and color of the main header on the screen
    func setupScreenHeaderLabel() {
        screenHeader.font = UIFont.screenHeaderFont()
        screenHeader.textColor = UIColor.lightBlueColor()
    }
    
    // This method sets up the font and color of all title labels
    func setupHeaderLabels() {
        employerHeader.font = UIFont.headerLabelFont()
        employerHeader.textColor = UIColor.lightBlackColor()
        
        titleHeader.font = UIFont.headerLabelFont()
        titleHeader.textColor = UIColor.lightBlackColor()
        
        biographyHeader.font = UIFont.headerLabelFont()
        biographyHeader.textColor = UIColor.lightBlackColor()
        
        ageHeader.font = UIFont.headerLabelFont()
        ageHeader.textColor = UIColor.lightBlackColor()
    }

    // This method sets up the font and color of all of the details
    func setupDetailLabels() {
        employerDetail.font = UIFont.detailLabelFont()
        employerDetail.textColor = UIColor.lightPinkColor()
        
        titleDetail.font = UIFont.detailLabelFont()
        titleDetail.textColor = UIColor.lightPinkColor()
        
        biographyDetail.font = UIFont.headerLabelFont()
        biographyDetail.textColor = UIColor.lightPinkColor()
    }
    
    @IBAction func viewEducationTapped(sender: AnyObject) {
    }
}

// This is an extension to the View Controller that will handle all of the animation
extension ViewController {
    
    // this method handles the user tapping on the profile image and will make the profile picture larger
    @IBAction func didTapOnImage(sender: AnyObject) {
        // create background View
        backgroundView = UIView(frame: self.view.frame)
        backgroundView?.setTranslatesAutoresizingMaskIntoConstraints(false)
        backgroundView?.backgroundColor = UIColor.transparentGrayBackground()
        backgroundView?.alpha = 0.0
        
        self.view.addSubview(backgroundView!)
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-(0)-[backgroundView]-(0)-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: ["backgroundView": backgroundView!]))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(0)-[backgroundView]-(0)-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: ["backgroundView": backgroundView!]))
        
        // create the new image view
        largeImageView = UIImageView(image: profileImage.image)
        largeImageView?.setTranslatesAutoresizingMaskIntoConstraints(false)
        largeImageView?.contentMode = .ScaleAspectFit
        
        // add new image to current view
        self.view.addSubview(largeImageView!)
        
        // position new image over existing image
        topLargeImageConstraint = NSLayoutConstraint(item: largeImageView!, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1.0, constant: profileImage.frame.origin.y)
        leftLargeImageConstraint = NSLayoutConstraint(item: largeImageView!, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: profileImage.frame.origin.x)
        heightImageConstraint = NSLayoutConstraint(item: largeImageView!, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: profileImage.frame.size.height)
        widthImageConstraint = NSLayoutConstraint(item: largeImageView!, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: profileImage.frame.size.width)
        
        // add new constraints
        self.view.addConstraints([topLargeImageConstraint!, leftLargeImageConstraint!])
        largeImageView?.addConstraints([heightImageConstraint!, widthImageConstraint!])
        
        if (UIAccessibilityIsReduceMotionEnabled()) {
            fadeInLargerImage()
        } else {
            growLargerImage()
        }
    }
    
    // This method will set the new image to the largest size and fade it in to view
    func fadeInLargerImage() {
        setLargeImageToFullScreen()
        
        // set the image to completely transparent so that it can fade in
        largeImageView?.alpha = 0.0
        
        UIView.animateWithDuration(0.75, animations: { [unowned self]() -> Void in
            self.backgroundView?.alpha = 1.0
            self.largeImageView?.alpha = 1.0
            }) { [unowned self](complete: Bool) -> Void in
                // add a gesture recognizer for closing the image
                self.addClosingRecognizer()
        }
    }
    
    // This method will grow the image view up to the larger size
    func growLargerImage() {
        // begin animations
        UIView.animateWithDuration(0.0, animations: { () -> Void in
            // This is here to force the new large image to display on top of the old image
            }) { [unowned self](completion: Bool) -> Void in
                
                // reposition the image
                self.setLargeImageToFullScreen()
                
                self.view.setNeedsLayout()
                
                // this animation does the resizing
                UIView.animateWithDuration(0.75, delay: 0, usingSpringWithDamping: 0.85, initialSpringVelocity: 10.0, options: UIViewAnimationOptions.allZeros, animations: { [unowned self]() -> Void in
                    // animation
                    self.backgroundView?.alpha = 1.0
                    // let the view grow
                    self.view.layoutIfNeeded()
                    }, completion: { [unowned self](secondCompletion: Bool) -> Void in
                        // add a gesture recognizer for closing the image
                        self.addClosingRecognizer()
                })
        }
    }
    
    // Sets the image constraints so that the image takes the entire screen and can scale appropriately
    func setLargeImageToFullScreen() {
        self.topLargeImageConstraint?.constant = 0.0
        self.leftLargeImageConstraint?.constant = 0.0
        self.heightImageConstraint?.constant = self.view.frame.size.height
        self.widthImageConstraint?.constant = self.view.frame.size.width
    }
    
    // add a tap recognizer to the background view
    func addClosingRecognizer() {
        var closeRecognizer = UITapGestureRecognizer(target: self, action: "closeLargeImage:")
        self.backgroundView?.addGestureRecognizer(closeRecognizer)
    }
    
    // This method handles taps while the profile image is enlarged and will reduce the size
    func closeLargeImage(sender: AnyObject) {
        if (UIAccessibilityIsReduceMotionEnabled()) {
            fadeOutLargerImage()
        } else {
            shrinkLargerImage()
        }
    }
    
    // This method will fade the image view out
    func fadeOutLargerImage() {
        UIView.animateWithDuration(0.75, animations: { [unowned self]() -> Void in
            self.backgroundView?.alpha = 0.0
            self.largeImageView?.alpha = 0.0
            }) { [unowned self](complete: Bool) -> Void in
            self.removeImageViews()
        }
    }
    
    // This method will shring the image view back down to the size of the profile view
    func shrinkLargerImage() {
        // reduce the large image to the size of the profile image
        topLargeImageConstraint?.constant = profileImage.frame.origin.y
        leftLargeImageConstraint?.constant = profileImage.frame.origin.x
        heightImageConstraint?.constant = profileImage.frame.size.height
        widthImageConstraint?.constant = profileImage.frame.size.width
        
        self.view.setNeedsLayout()
        
        UIView.animateWithDuration(0.75, delay: 0, usingSpringWithDamping: 0.95, initialSpringVelocity: 0.0, options: .allZeros, animations: { [unowned self]() -> Void in
            // make background view transparent again
            self.backgroundView?.alpha = 0.0
            self.view.layoutIfNeeded()
            }) { [unowned self](complete: Bool) -> Void in
                self.removeImageViews()
        }
    }
    
    // this method will remove all temporary views related to the larger image and 
    // nil out the constraints
    func removeImageViews() {
        // remove background view
        self.backgroundView?.removeFromSuperview()
        self.backgroundView = nil
        
        // remove large image view
        self.largeImageView?.removeFromSuperview()
        self.largeImageView = nil
        self.topLargeImageConstraint = nil
        self.leftLargeImageConstraint = nil
        self.heightImageConstraint = nil
        self.widthImageConstraint = nil
    }
    
}
