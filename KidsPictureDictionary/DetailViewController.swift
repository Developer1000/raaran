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
		var subCategoryName:NSString = ""

    var currentIndex = 0
	  var avAudioPlayer:AVAudioPlayer!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
			
			let name: NSString = arrImgNames.objectAtIndex(0) as! NSString
			
			let path = NSBundle.mainBundle().pathForResource(name as String, ofType:constants.keyImgTypeJPG, inDirectory:"\(cateoryName)/\(subCategoryName)/\(constants.imageFolder)/")

			myImageView.image = UIImage(contentsOfFile:path!)
			
			
			playAudioSound(cateoryName as String, subCategoryName:subCategoryName, fileName:name as String)
			let elementName = DataHelper.getCategoryElementName(cateoryName as String, subCategoryName: subCategoryName as String, ElementId: name as String)
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
            print("\(currentIndex)")
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
			
			
			let name: NSString = arrImgNames.objectAtIndex(currentIndex) as! NSString
			let imageName = "\(cateoryName)/\(subCategoryName)/image/\(name)\(constants.keyImgTypeJPG)"
			
			let path = NSBundle.mainBundle().resourceURL?.URLByAppendingPathComponent(imageName)
			
			myImageView.image = UIImage(contentsOfFile:(path?.absoluteString)!)

			let elementName = DataHelper.getCategoryElementName(cateoryName as String, subCategoryName: subCategoryName as String, ElementId: name as String)
			myLabel.text = elementName
			
			self.myImageView.layer.addAnimation(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
        
       playAudioSound(cateoryName as String, subCategoryName:subCategoryName, fileName:name as String)
    }

	func playAudioSound(forCategory:String,subCategoryName:NSString ,fileName:String)
	{
		let languageSelected = DataHelper.languageSelected()
        if (languageSelected.utf16.count > 0)
        {
            let soundFilePath = NSBundle.mainBundle().pathForResource(fileName, ofType:"\(constants.keySoundFileType)", inDirectory:"\(forCategory)/\(subCategoryName)/\(constants.soundFolder)/\(languageSelected)/")
            if soundFilePath != nil
            {
                let url:NSURL = NSURL(fileURLWithPath:soundFilePath!)
                do {
                    avAudioPlayer = try AVAudioPlayer(contentsOfURL:url )
                } catch {
                    avAudioPlayer = nil
                }
                avAudioPlayer?.prepareToPlay();
                avAudioPlayer?.play();
            }
            

 
        }
    }

}

