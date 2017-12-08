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
    let images: Array<String> = ["https://c1.staticflickr.com/6/5615/15570202337_0e64f5046e_k.jpg",
                                 "https://c1.staticflickr.com/4/3169/2846544061_cb7c04b46f_b.jpg",
                                 "https://i.redd.it/d8q1wkgu1awy.jpg",
                                 "http://www.kapstadt.de/webcam.jpg"]
    
    var cache: CacheOrganiser = CacheOrganiser()
    let req: MFSRequest = MFSRequest ()

    
    func getImage(imageId: String, completionBlock: @escaping (UIImage?) -> Void) {
        cache.get(imageAtURLString: imageId) { (image) in
            if image != nil {
                completionBlock (image)
            }
            else {
                self.req.fetchImage(urlStr: imageId, completionBlock: { (image) in
                    if image != nil{
                        self.cache.addImageToCache(image: image!)
                        let img = UIImage(data: (image?.imageData)! as Data)
                        completionBlock(img!)
                    }
                })
            }
        }
    }
}
 
