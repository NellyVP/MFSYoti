//
//  SlideShowController.swift
//  MyFirstSlideshow
//
//  Created by Nilofar Vahab poor on 18/10/2017.
//  Copyright © 2017 Yoti. All rights reserved.
//

import Foundation
import UIKit

class MFSController: NSObject {
    var cache: CacheOrganiser = CacheOrganiser()
    let req: MFSRequest = MFSRequest ()
    let images: Array<String> = ["https://c1.staticflickr.com/6/5615/15570202337_0e64f5046e_k.jpg",
                                 "https://c1.staticflickr.com/4/3169/2846544061_cb7c04b46f_b.jpg",
                                 "https://i.redd.it/d8q1wkgu1awy.jpg",
                                 "http://www.kapstadt.de/webcam.jpg"]
    
    func getImage(imageId: String, completionBlock: @escaping (UIImage?) -> Void) {
        var cachedImage = UIImage()
        
        cache.get(imageAtURLString: imageId) { (image) in
            if image != nil {
                cachedImage = image!
                completionBlock (cachedImage)
            }
            else {
                self.req.fetchImage(urlStr: imageId, completionBlock: { (downloadedImage, maxAge) in
                    if downloadedImage != nil {
                        self.cache.add(image: downloadedImage!, withIdentifier: imageId, maxAge:maxAge )
                        cachedImage = downloadedImage!
                        completionBlock (cachedImage)
                    }
                })
            }
        }
    }
}
 
