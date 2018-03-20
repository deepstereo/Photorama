//
//  PhotoDataSource.swift
//  Photorama
//
//  Created by Sergey Kozak on 19/03/2018.
//  Copyright © 2018 Centennial. All rights reserved.
//

import Foundation
import UIKit

class PhotoDataSource: NSObject, UICollectionViewDataSource {
	
	var photos = [Photo]()
	
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return photos.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let identifier = "PhotoCollectionViewCell"
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
		return cell
	}
	
	
	
	
}

