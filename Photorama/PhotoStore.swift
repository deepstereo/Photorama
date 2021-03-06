//
//  PhotoStore.swift
//  Photorama
//
//  Created by Sergey Kozak on 12/03/2018.
//  Copyright © 2018 Centennial. All rights reserved.
//

import Foundation
import UIKit

enum ImageResult {
	case success(UIImage)
	case failure(Error)
}

enum PhotoError: Error {
	case imageCreationError
}


enum PhotosResult {
	case success([Photo])
	case failure(Error)
}


class PhotoStore {
	
	private let session: URLSession = {
		let config = URLSessionConfiguration.default
		return URLSession(configuration: .default)
	}()
	
	func fetchInterestingPhotos(completion: @escaping (PhotosResult) -> Void) {
		
		let url = FlickrAPI.interestingPhotosURL
		let request = URLRequest(url: url)
		let task = session.dataTask(with: request) { (data, response, error) -> Void in
			let result = self.processPhotosRequest(data: data, error: error)
			OperationQueue.main.addOperation {
				completion(result)
			}
		}
		task.resume()
		
	}
	
	func fetchImage(for photo: Photo, completion: @escaping (ImageResult) -> Void) {
		let photoURL = photo.remoteURL
		let request = URLRequest(url: photoURL)
		
		let task = session.dataTask(with: request) {
			(data, response, errror) -> Void in
			let result = self.processImageRequest(data: data, error: errror)
			OperationQueue.main.addOperation {
				completion(result)
			}
		}
		task.resume()
	}
	
	private func processImageRequest(data: Data?, error: Error?) -> ImageResult {
		guard
			let imageData = data,
			let image = UIImage(data: imageData) else {
				if data == nil {
					return .failure(error!)
				} else {
					return .failure(PhotoError.imageCreationError)
				}
		}
		return .success(image)
	}

	
	private func processPhotosRequest(data: Data?, error: Error?) -> PhotosResult {
		guard let jsonData = data else {
			return PhotosResult.failure(error!)
		}
		
		return FlickrAPI.photos(fromJSON: jsonData)
	}
	
	
	
}
