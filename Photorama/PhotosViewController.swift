//
//  PhotosViewController.swift
//  Photorama
//
//  Created by Sergey Kozak on 12/03/2018.
//  Copyright © 2018 Centennial. All rights reserved.
//

import UIKit



class PhotosViewController: UIViewController, UICollectionViewDelegate {
	
	@IBOutlet weak var collectionView: UICollectionView!
	
	let photoDataSource = PhotoDataSource()
	var store: PhotoStore!


    override func viewDidLoad() {
        super.viewDidLoad()
		
		collectionView.dataSource = photoDataSource
		collectionView.delegate = self
		
		store.fetchInterestingPhotos { (photosResult) -> Void in
			switch photosResult {
			case let .success(photos):
				print("Successfully found \(photos.count) photos")
				self.photoDataSource.photos = photos
			case let .failure(error):
				print("Error fetching interesting photos: \(error)")
				self.photoDataSource.photos.removeAll()
			}
			
			self.collectionView.reloadSections(IndexSet(integer:0))
		}
    }
	
	
	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		
		let photo = photoDataSource.photos[indexPath.row]
		
		store.fetchImage(for: photo) { (result) in
			guard let photoIndex = self.photoDataSource.photos.index(of: photo),
				case let .success(image) = result else {
					return
			}
			let photoIndexPath = IndexPath(item: photoIndex, section: 0)
			if let cell = self.collectionView.cellForItem(at: photoIndexPath) as? PhotoCollectionViewCell {
				cell.update(with: image)
			}
		}
	}
	
	
	

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
