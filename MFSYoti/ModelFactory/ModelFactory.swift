//
//  ModelFactory.swift
//  MFSYoti
//
//  Created by Nilofar Vahab poor on 06/12/2017.
//  Copyright © 2017 Nilofar Vahab poor. All rights reserved.
//

import UIKit

class ModelFactory: NSObject {

    func createImageFrom(urlString: String, data: Data, response: HTTPURLResponse) -> MFSImage {
        let httpResponse = response
        var maxAgeDoubleValue = 0.0
        if let contentType = httpResponse.allHeaderFields["Cache-Control"] as? String {
            if let maxAgeString = contentType.components(separatedBy: "=").last {
                if let maxAge = maxAgeString.components(separatedBy: ",").first {
                    maxAgeDoubleValue = (maxAge as NSString).doubleValue
                }
            }
        }
        let image:MFSImage = MFSImage(imgID: String().md5(urlString), imgURL: urlString, imgData: data as NSData, preAccessTime: Date() as NSDate, numberOfRetrieval: 1, cachePeriod: maxAgeDoubleValue)
        return image
    }
}
