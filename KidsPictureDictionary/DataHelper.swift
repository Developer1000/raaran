//
//  DataHelper.swift
//  KidsPictureDictionary
//
//  Created by Mahesh Bajaj on 02/04/15.
//  Copyright (c) 2015 Cognizant Technology Solutions. All rights reserved.
//

import Foundation

class DataHelper : NSObject
{
	
	
	// To get appMetaData.plist data in an array .
	class func getMasterData() ->NSArray
	{
		var path = NSBundle.mainBundle().pathForResource(constants.masterDataFileName, ofType:"plist")
		var metaData = NSDictionary(contentsOfFile:path!)
		var data: AnyObject? = metaData?.valueForKey(constants.keyAppMenuConfig)
		
		return data as NSArray
	}
	
	// To get appMetaData.plist data in an array .
	class func getSubCategoryList(fromCategory:String) ->NSArray
	{
		var path =
		  NSBundle.mainBundle().pathForResource("subCategory", ofType:"plist", inDirectory:"\(fromCategory)/")
		var metaData = NSDictionary(contentsOfFile:path!)
		var data: AnyObject? = metaData?.valueForKey(constants.keySubCategoryList)
		
		return data as NSArray
	}
	
	// To get detailed data for selected category like animal.plist
	class func getDetailListData(resuouceName:NSString)->NSArray
	{
		
		var path = NSBundle.mainBundle().pathForResource("\(resuouceName)/\(resuouceName)", ofType:"plist")
		var metaData = NSDictionary(contentsOfFile:path!)
		var data: AnyObject? = metaData?.valueForKey(constants.keyResources)
		return data as NSArray
	}
	
	// To get detailed data for selected category and subCategory like animal.plist
	class func getDetailListData(categoryName:String, resuouceName:String)->NSArray
	{
		
		var path = NSBundle.mainBundle().pathForResource("\(categoryName)/\(categoryName)", ofType:"plist")
		var metaData = NSDictionary(contentsOfFile:path!)
		var allSubCategories:NSDictionary = metaData?.valueForKey(constants.keyResources) as NSDictionary
		var selectedSubCategoryData: AnyObject? = allSubCategories.valueForKey(resuouceName)
		return selectedSubCategoryData as NSArray
	}
	
	// Localzation
	// To get categrory name in selected language
	class func getCategoryElementName(categoryName:String,subCategoryName:String, ElementId:String)->String
	{
		
		var path = NSBundle.mainBundle().pathForResource("\(categoryName)/\(subCategoryName)/\(subCategoryName)", ofType:"plist")
		var metaData = NSDictionary(contentsOfFile:path!)
		var languageSelected = DataHelper.languageSelected()
		var key = "\(ElementId)_\(languageSelected)"
		var data: AnyObject? = metaData?.valueForKey(key)
		return data as String
	}
	
	// Returns the selected language
	class func languageSelected()->String
	{
		return constants.languageSelected
	}
}
