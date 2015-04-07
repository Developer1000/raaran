//
//  DetailViewController.swift
//  KidsPictureDictionary
//
//  Created by IMEMSP on 27/03/15.
//  Copyright (c) 2015 Cognizant Technology Solutions. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class DetailViewController: UIViewController {
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myLabel: UILabel!

    var currImage: UIImage?
    var textHeading: String?
    var arrImg:Array<UIImage> = []
	  var arrImgNames:NSArray = []
  	var cateoryName:NSString = ""

    var currentIndex = 0
	  var avAudioPlayer:AVAudioPlayer!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        println("Detail view controller")
			  textHeading = "fasfd"
        myLabel.text = textHeading
			
			var name: NSString = arrImgNames.objectAtIndex(0) as NSString
			var imageName = "\(cateoryName)/images/\(name)\(constants.keyImgTypeJPG)"

			var path = NSBundle.mainBundle().resourcePath?.stringByAppendingPathComponent(imageName)

			myImageView.image = UIImage(contentsOfFile:path!)
			
			var languageSelected = DataHelper.languageSelected()
			var soundFileName = "\(cateoryName)/sounds/\(languageSelected)/2.mp3)"
			var soundFilePath = NSBundle.mainBundle().resourcePath?.stringByAppendingPathComponent(soundFileName)
			
			var error:NSError?
			var url:NSURL = NSURL(fileURLWithPath:soundFilePath!)!
			//var audioPlayer:AVAudioPlayer = AVAudioPlayer
			
			avAudioPlayer = AVAudioPlayer(contentsOfURL:url ,error: &error)
			avAudioPlayer?.prepareToPlay();
			avAudioPlayer?.play();
		  // avAudioPlayer = AVPlayer(URL:url)
			//avAudioPlayer?.play()
		 var elementName = DataHelper.getCategoryElementName(cateoryName, ElementId:name)
			 myLabel.text = elementName

        let swipL = UISwipeGestureRecognizer(target: self, action: "swipe:")
        swipL.direction = .Left
        self.view.addGestureRecognizer(swipL)
        
        
        let swipR = UISwipeGestureRecognizer(target: self, action: "swipe:")
        swipR.direction = .Right
        self.view.addGestureRecognizer(swipR)


    }
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    
    
    func swipe(gest: UISwipeGestureRecognizer)
    {
        var selectedIndex = currentIndex
        if gest.direction == .Left
        {
            ++selectedIndex
        }
        else
        {
            --selectedIndex
        }
        
        if selectedIndex >= 0 && selectedIndex < arrImgNames.count
        {
            println("\(currentIndex)")
            currentIndex = selectedIndex
            animateImg(gest.direction == .Left ? true : false)
        }
    }

    
    func animateImg(fromLeft : Bool)
    {
        let slideInFromLeftTransition = CATransition()
        slideInFromLeftTransition.type = kCATransitionPush
        
        slideInFromLeftTransition.subtype = fromLeft == true ? kCATransitionFromRight : kCATransitionFromLeft
        slideInFromLeftTransition.duration = 0.5
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        slideInFromLeftTransition.fillMode = kCAFillModeRemoved
			
			
			var name: NSString = arrImgNames.objectAtIndex(currentIndex) as NSString
			var imageName = "\(cateoryName)/images/\(name)\(constants.keyImgTypeJPG)"
			
			var path = NSBundle.mainBundle().resourcePath?.stringByAppendingPathComponent(imageName)
			
			myImageView.image = UIImage(contentsOfFile:path!)

			var elementName = DataHelper.getCategoryElementName(cateoryName, ElementId:name)
			myLabel.text = elementName
			
			self.myImageView.layer.addAnimation(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
        

    }

}

