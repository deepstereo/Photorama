//
//  PhotoDetailViewController.swift
//  Photorama
//
//  Created by Sergey Kozak on 19/03/2018.
//  Copyright © 2018 Centennial. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {
	
	@IBOutlet weak var imageView: UIImageView!
	
	var photo: Photo! {
		didSet {
			navigationItem.title = photo.title
		}
	}
	var store: PhotoStore!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		store.fetchImage(for: photo, completion: { (result) -> Void in
			switch result {
			case let .success(image):
				self.imageView.image = image
			case let .failure(error):
				print("Error fetching image for photo: \(error)")
			}
		})
	}

}
