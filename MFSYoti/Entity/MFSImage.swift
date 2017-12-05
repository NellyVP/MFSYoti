//
//  MFSImage.swift
//  MyFirstSlideshow
//
//  Created by Nilofar Vahab poor on 18/10/2017.
//  Copyright © 2017 Yoti. All rights reserved.
//

import UIKit

class MFSImage: NSObject {
    var imageID: String?
    var imageData: NSData?
    var lastAccessTime: NSDate?
    var maxAge: Double?
    var accessCount: Int!
    
    
    init (imgID: String ,imgData: NSData, preAccessTime: NSDate, numberOfRetrieval: Int, cachePeriod: Double) {
        super.init()
        imageID         = imgID
        imageData       = imgData
        lastAccessTime  = preAccessTime
        accessCount     = numberOfRetrieval
        maxAge          = cachePeriod
    }
}

