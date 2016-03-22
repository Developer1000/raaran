//
//  HomeLayoutViewController.swift
//  KidsPictureDictionary
//
//  Created by IMEMSP on 27/03/15.
//  Copyright (c) 2015 Cognizant Technology Solutions. All rights reserved.
//

import Foundation
import UIKit


let reuseIdentifier = "colCell"


class HomeLayoutViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
	let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
	let titles = ["Animal","Transport","Days,Colours & Shape","Human Body","Vegetables & Fruits","Peoples & RelationShips"]
	
	
	var app_menu_data:NSArray?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		app_menu_data =  DataHelper.getMasterData()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
		return 1
	}
	
	override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return app_menu_data?.count ?? 0
	}
	
	override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CollectionViewCell
		
		let categoryDetails:NSDictionary = self.app_menu_data?.objectAtIndex(indexPath.row) as! NSDictionary
		let categoryTitleName = categoryDetails.valueForKey(constants.keyTitleMenu) as? String
	
		cell.title.text = categoryTitleName
		
		//let curr = indexPath.row + 1
	//	let imgName = "\(curr)/\(curr)\(constants.keyImgTypeJPG)"
		//cell.thumbImage.image = UIImage(named: imgName)
		
		let imageName = "\(categoryTitleName)/\(categoryTitleName)\(constants.keyImgTypePNG)"
		
		print("path \(imageName)")
		let path = NSBundle.mainBundle().resourceURL?.URLByAppendingPathComponent(imageName)
		
		cell.thumbImage.image = UIImage(named: (path?.absoluteString)!)
		
		return cell
	}
	
	func collectionView(collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
			return CGSize(width: 170, height: 300)
	}
	
	func collectionView(collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		insetForSectionAtIndex section: Int) -> UIEdgeInsets {
			return sectionInsets
	}
	
	override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
	{
		let categoryDetails:NSDictionary = self.app_menu_data?.objectAtIndex(indexPath.row) as! NSDictionary
		
		let hasSubCategory:Bool = categoryDetails.valueForKey("hasSubCategory") as! Bool
		
		if hasSubCategory
		{
			performSegueWithIdentifier("subCategory", sender:indexPath)
		}else
		{
			//performSegueWithIdentifier("detail", sender: sender)
		}
		
	}
	
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
	{
		if segue.identifier == "detail"
		{
			let indexPath:NSIndexPath = sender as! NSIndexPath
			let categoryDetails:NSDictionary = self.app_menu_data?.objectAtIndex(indexPath.row) as! NSDictionary
			let vc = segue.destinationViewController as! DetailViewController
			let categoryName:NSString = categoryDetails.valueForKey(constants.keyMenu)! as! NSString
			vc.arrImgNames = DataHelper.getDetailListData(categoryName)
			vc.textHeading = self.titles[indexPath.row % 5]
			vc.cateoryName = categoryName;
			
		}else if segue.identifier == "subCategory"
		{
			let indexPath:NSIndexPath = sender as! NSIndexPath
			let categoryDetails:NSDictionary = self.app_menu_data?.objectAtIndex(indexPath.row) as! NSDictionary
			
			let vc = segue.destinationViewController as! SubCategoryViewController
			let categoryName = categoryDetails.valueForKey(constants.keyTitleMenu)! as! NSString
		//	vc.subCategoryList = DataHelper.getDetailListData(subCategoryName)
			vc.cateoryName = categoryName;
			
			
		}
		
	}
	
	//	override func performSegueWithIdentifier(identifier: String?, sender: AnyObject?) {
	//
	//
	//
	//	}
	
	
}
