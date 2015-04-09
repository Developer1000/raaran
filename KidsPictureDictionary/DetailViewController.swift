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
        
        
        var name: NSString = arrImgNames.objectAtIndex(0) as NSString
        
        var path = NSBundle.mainBundle().pathForResource(name, ofType:constants.keyImgTypeJPG, inDirectory:"\(cateoryName)/\(subCategoryName)/\(constants.imageFolder)/")
        
        myImageView.image = UIImage(contentsOfFile:path!)
        
        
        playAudioSound(cateoryName, subCategoryName:subCategoryName, fileName:name)
        var elementName = DataHelper.getCategoryElementName(cateoryName, subCategoryName: subCategoryName, ElementId: name)
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
        var imageName = "\(cateoryName)/\(subCategoryName)/image/\(name)\(constants.keyImgTypeJPG)"
        
        var path = NSBundle.mainBundle().resourcePath?.stringByAppendingPathComponent(imageName)
        
        myImageView.image = UIImage(contentsOfFile:path!)
        
        var elementName = DataHelper.getCategoryElementName(cateoryName, subCategoryName: subCategoryName, ElementId: name)
        myLabel.text = elementName
        
        self.myImageView.layer.addAnimation(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
        
        playAudioSound(cateoryName, subCategoryName:subCategoryName, fileName:name)
    }
    
    func playAudioSound(forCategory:String,subCategoryName:NSString ,fileName:String)
    {
        var languageSelected = DataHelper.languageSelected()
        var soundFileName = "\(forCategory)/\(subCategoryName)/sounds/\(languageSelected)/)"
        var soundFilePath = NSBundle.mainBundle().pathForResource(fileName, ofType:"\(constants.keySoundFileType)", inDirectory:"\(forCategory)/\(subCategoryName)/\(constants.soundFolder)/\(languageSelected)/")
        
        var error:NSError?
        var url:NSURL = NSURL(fileURLWithPath:soundFilePath!)!
        avAudioPlayer = AVAudioPlayer(contentsOfURL:url ,error: &error)
        avAudioPlayer?.prepareToPlay();
        avAudioPlayer?.play();
    }
}

