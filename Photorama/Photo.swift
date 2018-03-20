//
//  Photo.swift
//  Photorama
//
//  Created by Sergey Kozak on 12/03/2018.
//  Copyright © 2018 Centennial. All rights reserved.
//

import Foundation

class Photo: Equatable {
	
	
	var title: String
	var photoID: String
	var remoteURL: URL
	var dateTaken: Date
	
	init(title: String, photoID: String, remoteURL: URL, dateTaken: Date) {
		self.title = title
		self.photoID = photoID
		self.remoteURL = remoteURL
		self.dateTaken = dateTaken
	}
	
	static func ==(lhs: Photo, rhs: Photo) -> Bool {
		return lhs.photoID == rhs.photoID
	}
	
}
