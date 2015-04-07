//
//  DataHelper.swift
//  KidsPictureDictionary
//
//  Created by MSP_MacBookPro on 02/04/15.
//  Copyright (c) 2015 Cognizant Technology Solutions. All rights reserved.
//

import Foundation


class DataHelper : NSObject
{
	
	class func getMasterData() ->NSArray
	{
		var path = NSBundle.mainBundle().pathForResource(constants.masterDataFileName, ofType:"plist")
		var metaData = NSDictionary(contentsOfFile:path!)
		var data: AnyObject? = metaData?.valueForKey(constants.keyAppMenuConfig)
		
		return data as NSArray
	}
	
	class func getDetailListData(resuouceName:NSString)->NSArray
	{
		
		var path = NSBundle.mainBundle().pathForResource("\(resuouceName)/\(resuouceName)", ofType:"plist")
		var metaData = NSDictionary(contentsOfFile:path!)
		var data: AnyObject? = metaData?.valueForKey(constants.keyResources)		
		return data as NSArray
	}

	class func getCategoryElementName(categoryName:String,ElementId:String)->String
	{
		
		var path = NSBundle.mainBundle().pathForResource("\(categoryName)/\(constants.elementNameDataFile)", ofType:"plist")
		var metaData = NSDictionary(contentsOfFile:path!)
		var languageSelected = DataHelper.languageSelected()
		var key = "\(ElementId)_\(languageSelected)"
		var data: AnyObject? = metaData?.valueForKey(key)
		return data as String
	}

	
	class func languageSelected()->String
	{
		  return constants.languageSelected
	}
}
