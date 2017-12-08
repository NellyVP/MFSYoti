//
//  MFSImage.swift
//  MyFirstSlideshow
//
//  Created by Nilofar Vahab poor on 18/10/2017.
//  Copyright © 2017 Yoti. All rights reserved.
//

import UIKit

public class MFSImage: NSObject {
    var imageID: String?
    var imageData: NSData?
    var lastAccessTime: NSDate?
    var maxAge: Double?
    var accessCount: Int!
    var imageURL: String?
    
    
    init (imgID: String, imgURL: String, imgData: NSData, preAccessTime: NSDate, numberOfRetrieval: Int, cachePeriod: Double) {
        super.init()
        imageID         = imgID
        imageURL        = imgURL
        imageData       = imgData
        lastAccessTime  = preAccessTime
        accessCount     = numberOfRetrieval
        maxAge          = cachePeriod
    }
}

