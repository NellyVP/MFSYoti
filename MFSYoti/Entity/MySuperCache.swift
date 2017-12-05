//
//  MySuperCache.swift
//  MyFirstSlideshow
//
//  Created by Nilofar Vahab poor on 18/10/2017.
//  Copyright © 2017 Yoti. All rights reserved.
//

import Foundation
import UIKit
private let kMaxNumberOfItems: Int = 10000

public protocol MySuperCache {
    func get(imageAtURLString imageURLString: String, completionBlock: @escaping (UIImage?) -> Void)
    func add(image: UIImage, withIdentifier: String, maxAge:Double)
}

open class CacheOrganiser: MySuperCache {
    var imagesCache = [MFSImage]()
    var maxAgeDoubleValue = 0.0
    
    public func get(imageAtURLString imageURLString: String, completionBlock: @escaping (UIImage?) -> Void) {
        if let image = findImageWithId(imageID: imageURLString) {
            self.discardImageOverMaxAgeLimit(withIdentifier: imageURLString, completion: { (needsDownload) in
                if !needsDownload {
                    completionBlock (image)
                }
                else {
                    completionBlock (nil)
                }
            })
        }
        else {
            completionBlock (nil)

        }
    }
    
    public func add(image: UIImage, withIdentifier: String, maxAge: Double) {
        addImageToCache(image: image, withIdentifier: withIdentifier, maxAge:maxAge)
    }
    
    func findImageWithId(imageID: String) -> UIImage? {
        var retuningImage: MFSImage?
        if (self.imagesCache.count > 0) {
            for eachImage in self.imagesCache {
                if eachImage.imageID == imageID {
                    // imageFound
                    eachImage.accessCount = Int(eachImage.accessCount + 1)
                    eachImage.lastAccessTime = NSDate()
                    retuningImage = eachImage
                    return UIImage(data:(retuningImage?.imageData as Data?)!)
                }
            }
        }
        return nil
    }
    
    func addImageToCache(image: UIImage, withIdentifier: String, maxAge:Double) {
        self.checkTodiscardOverCacheLimit()
        let mfsImg = MFSImage (imgID: withIdentifier, imgData: (UIImagePNGRepresentation(image) as NSData?)!, preAccessTime: Date() as NSDate, numberOfRetrieval: 1, cachePeriod:maxAge)
        imagesCache.append(mfsImg)
    }
    
    func checkTodiscardOverCacheLimit() -> Void {
        var imagesCacheCopy = [MFSImage]()
        imagesCacheCopy = imagesCache
        if (imagesCacheCopy.count < kMaxNumberOfItems) {
            return
        }
        DispatchQueue.global(qos: .userInitiated).async { // 1
            //Order the cache array based on the least used image
            imagesCacheCopy.sort(by: { $0.accessCount < $1.accessCount })
            imagesCacheCopy.remove(at:(0))
        }
        DispatchQueue.main.async { // 2
            let lockQueue = DispatchQueue(label: "self")
            lockQueue.sync {
                self.imagesCache = imagesCacheCopy
            }
        }
    }
    func discardImageOverMaxAgeLimit(withIdentifier identifier: String, completion: @escaping (_ imageDiscarded: Bool) -> Void) {
        //if imageMax age is gone - then discharge it
        //What if there is no age limit?
        //Then discard the image and download again
        var imagesCacheCopy = [MFSImage]()
        
        for img in self.imagesCache {
            if img.imageID == identifier {
                //image found
                let kDiscardInterval = -img.maxAge!
                let lastAccessedTime = img.lastAccessTime?.timeIntervalSinceNow
                let discardNeed = Double(lastAccessedTime!) < kDiscardInterval
                if (discardNeed) {
                    let lockQueue = DispatchQueue(label: "self")
                    
                    lockQueue.sync {
                        imagesCacheCopy = self.imagesCache
                    }
                    DispatchQueue.global(qos: .userInitiated).async {
                        // 1
                        //Order the cache array based on the least used image
                        if let index = self.imagesCache.index(of:img) {
                            imagesCacheCopy.remove(at:(index))
                        }
                        
                        DispatchQueue.main.async { // 2
                            let lockQueue = DispatchQueue(label: "self")
                            lockQueue.sync {
                                self.imagesCache = imagesCacheCopy
                            }
                        }
                    }
                }
                completion (discardNeed)
            }
            
        }
    }
    
    func removeImageFromCache(identifier: String) -> Bool{

        var removed = false
        for img in self.imagesCache {
            if img.imageID == identifier {
                if let index = self.imagesCache.index(of:img) {
                    self.imagesCache.remove(at:(index))
                    removed = true
                }
            }
        }
        return removed
    }
}

