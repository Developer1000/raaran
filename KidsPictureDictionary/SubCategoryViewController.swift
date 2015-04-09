//
//  SubCategoryViewController.swift
//  KidsPictureDictionary
//
//  Created by MSP_MacBookPro on 05/04/15.
//  Copyright (c) 2015 Cognizant Technology Solutions. All rights reserved.
//

import UIKit

class SubCategoryViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout {

	
	let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
	let titles = ["Raptels","Mamels","AquaticBird"]
	
	var subCategoryList:NSArray = []
	var cateoryName:NSString = ""

	
	var subCategoryDataList:NSArray?
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
			

    }

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		subCategoryDataList =  DataHelper.getSubCategoryList(cateoryName)

	}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

	override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
		return 1
	}
	
	override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return subCategoryDataList?.count ?? 0
	}
	
	override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as CollectionViewCell
		
		var subCategoryDetails:NSDictionary = self.subCategoryDataList?.objectAtIndex(indexPath.row) as NSDictionary
		var subCategoryName: AnyObject? = subCategoryDetails.valueForKey(constants.keyMenu)
		cell.title.text = subCategoryName as NSString
		
		let curr = indexPath.row + 1
		let imgName = "pin\(curr)\(constants.keyImgTypeJPG)"
		cell.thumbImage.image = UIImage(named: imgName)
		return cell
	}
	
	func collectionView(collectionView: UICollectionView!,
		layout collectionViewLayout: UICollectionViewLayout!,
		sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
			return CGSize(width: 170, height: 300)
	}
	
	func collectionView(collectionView: UICollectionView!,
		layout collectionViewLayout: UICollectionViewLayout!,
		insetForSectionAtIndex section: Int) -> UIEdgeInsets {
			return sectionInsets
	}
	
	override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
	{
		performSegueWithIdentifier("detail", sender:indexPath)

	}
	
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
	{
		if segue.identifier == "detail"
		{
			let indexPath:NSIndexPath = sender as NSIndexPath
			var categoryDetails:NSDictionary = self.subCategoryDataList?.objectAtIndex(indexPath.row) as NSDictionary
			let vc = segue.destinationViewController as DetailViewController
			var subCategoryName:NSString = categoryDetails.valueForKey(constants.keyMenu)! as NSString
			vc.arrImgNames = DataHelper.getDetailListData(cateoryName, resuouceName:subCategoryName)
			vc.subCategoryName = subCategoryName
			vc.cateoryName = self.cateoryName
			
		}else if segue.identifier == "subCategory"
		{
			
			
		}
		
	}
	

	
}
