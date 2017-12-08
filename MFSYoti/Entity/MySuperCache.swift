//
//  MySuperCache.swift
//  MyFirstSlideshow
//
//  Created by Nilofar Vahab poor on 18/10/2017.
//  Copyright © 2017 Yoti. All rights reserved.
//

import Foundation
import UIKit


public protocol MySuperCache {
    func get(imageAtURLString imageURLString: String, completionBlock: @escaping (UIImage?) -> Void)
    func addImageToCache(image:MFSImage)
}

open class CacheOrganiser: MySuperCache {
    var imagesCache = [MFSImage]()
    var maxAgeDoubleValue = 0.0
    var kMaxNumberOfItems: Int = 10000

    
    public func get(imageAtURLString imageURLString: String, completionBlock: @escaping (UIImage?) -> Void) {
        if let image = findImageFromCache(urlString: String().md5(imageURLString)) {
            if checkIfImageNeedsRedownload(image: image) {
                removeImageFromCache(image: image)
                completionBlock(nil)
            }
            else {
                updateImageAccessInfo(image: image)
                completionBlock(UIImage(data:(image.imageData as Data?)!))
            }
        }
        else {
            completionBlock(nil)
        }
    }
    func findImageFromCache(urlString:String) -> MFSImage? {
        var image: MFSImage?
        if (self.imagesCache.count > 0) {
            for iteratingImg in self.imagesCache {                
                if iteratingImg.imageID == urlString {
                    // imageFound
                    image = iteratingImg
                }
            }
        }
        return image
    }
    
    public func addImageToCache(image: MFSImage) {
        self.checkTodiscardOverCacheLimit()
        imagesCache.append(image)
    }
    
    func updateImageAccessInfo(image:MFSImage) {
        image.accessCount = Int(image.accessCount + 1)
        image.lastAccessTime = NSDate()
    }
    
    func checkIfImageNeedsRedownload(image:MFSImage) -> Bool {
        let kDiscardInterval = -image.maxAge!
        let lastAccessedTime = image.lastAccessTime?.timeIntervalSinceNow
        let discardNeed = Double(lastAccessedTime!) < kDiscardInterval
        return discardNeed
    }
    
    func removeImageFromCache(image:MFSImage) -> Void {
        var imagesCacheCopy = [MFSImage]()

        let lockQueue = DispatchQueue(label: "self")
        
        lockQueue.sync {
            imagesCacheCopy = self.imagesCache
            if let index = self.imagesCache.index(of:image) {
                imagesCacheCopy.remove(at:(index))
            }
            self.imagesCache = imagesCacheCopy
        }
    }
    func checkTodiscardOverCacheLimit() -> Void {
        var imagesCacheCopy = [MFSImage]()
        imagesCacheCopy = imagesCache
        if (imagesCacheCopy.count < kMaxNumberOfItems) {
            return
        }
        
        let lockQueue = DispatchQueue(label: "cacheQueue")
        
        lockQueue.sync {
            imagesCacheCopy.sort(by: { $0.accessCount < $1.accessCount })
            imagesCacheCopy.remove(at:(0))
            self.imagesCache = imagesCacheCopy

        }
    }
}

