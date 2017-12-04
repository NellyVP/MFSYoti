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
//    func get(imageAtURLString imageURLString: String, completionBlock: @escaping (UIImage?) -> Void) {
//        <#code#>
//    }
    
    let images: Array<String> = ["https://c1.staticflickr.com/6/5615/15570202337_0e64f5046e_k.jpg",
                                 "https://c1.staticflickr.com/4/3169/2846544061_cb7c04b46f_b.jpg",
                                 "https://i.redd.it/d8q1wkgu1awy.jpg",
                                 "http://www.kapstadt.de/webcam.jpg"]
    
    /*func get(imageAtURLString imageURLString: String, completionBlock: @escaping (MFSImage?) -> Void) {
        /*if let returnedImage = MySuperCache.sharedInstance.findImageWithId(imageID: imageURLString) {
            //image exists
            //check the max age
            MySuperCache.sharedInstance.discardImageOverMaxAgeLimit(image: returnedImage, completion: { (discarded) in
                let imageDiscarded = discarded
                if imageDiscarded {
                    //download the image again
                    let currentImageURL = NSURL(string:imageURLString)
                    currentImageURL?.fetchImage(completion: { (image) in
                        MySuperCache.sharedInstance.addImageToCache(image: image)
                        completionBlock (image)

                    })
                }
                else {
                    // use the image here if needed
                    returnedImage.accessCount = Int(returnedImage.accessCount! + 1)
                        completionBlock (returnedImage)
                }

            })
            
        }
        else {
            //image doesn't exists
            //check the cache size and download the image
            let currentImageURL = NSURL(string:imageURLString)
            currentImageURL?.fetchImage(completion: { (image) in
                MySuperCache.sharedInstance.addImageToCache(image: image)
                    completionBlock (image)
               // }
            })
        }
    }*/
    }
}*/
}
 
