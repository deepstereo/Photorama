//
//  PhotosViewController.swift
//  Photorama
//
//  Created by Sergey Kozak on 12/03/2018.
//  Copyright © 2018 Centennial. All rights reserved.
//

import UIKit



class PhotosViewController: UIViewController {
	
	@IBOutlet weak var imageView: UIImageView!
	var store: PhotoStore!


    override func viewDidLoad() {
        super.viewDidLoad()
		
		store.fetchInterestingPhotos { (photosResult) -> Void in
			switch photosResult {
			case let .success(photos):
				print("Successfully found \(photos.count) photos")
				if let firstPhoto = photos.first {
					self.updateImageView(for: firstPhoto)
				}
			case let .failure(error):
				print("Error fetching interesting photos: \(error)")
			}
			
		}
    }
	
	
	func updateImageView(for photo: Photo) {
		store.fetchImage(for: photo) { (imageResult) in
			switch imageResult {
			case let .success(image):
				self.imageView.image = image
			case let .failure(error):
				print("error downloading image: \(error)")
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
