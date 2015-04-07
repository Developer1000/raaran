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
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as CollectionViewCell
    
			 var categoryDetails:NSDictionary = self.app_menu_data?.objectAtIndex(indexPath.row) as NSDictionary
    var categoryName: AnyObject? = categoryDetails.valueForKey(constants.keyMenu)
    cell.title.text = categoryName as NSString//self.titles[indexPath.row%5]
    
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
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    println(segue.identifier)
    println(sender)
    if(segue.identifier == "detail")
    {
      let cell = sender as CollectionViewCell
      let indexPath = self.collectionView!.indexPathForCell(cell)
      let vc = segue.destinationViewController as DetailViewController
      var categoryDetails:NSDictionary = self.app_menu_data?.objectAtIndex(indexPath!.row) as NSDictionary
      var categoryName:NSString = categoryDetails.valueForKey(constants.keyMenu)! as NSString
      vc.arrImgNames = DataHelper.getDetailListData(categoryName)
      vc.textHeading = self.titles[indexPath!.row % 5]
      vc.cateoryName = categoryName;
    }
  }
  
}
