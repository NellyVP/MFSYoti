//
//  MFSRequest.swift
//  MyFirstSlideshow
//
//  Created by Nilofar Vahab poor on 18/10/2017.
//  Copyright © 2017 Yoti. All rights reserved.
//

import Foundation
import UIKit

class MFSRequest: NSObject, URLSessionDataDelegate, URLSessionTaskDelegate{
    func fetchImage(urlStr:String, completionBlock: @escaping (UIImage?, Double) -> Void)  {
        let url     = NSURL(string: urlStr)
        let request = URLRequest(url:url! as URL)
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error == nil {
                if let newData = data {
                    let httpResponse = response as! HTTPURLResponse
                    var maxAgeDoubleValue = 0.0
                    if let contentType = httpResponse.allHeaderFields["Cache-Control"] as? String {
                        if let maxAgeString = contentType.components(separatedBy: "=").last {
                            if let maxAge = maxAgeString.components(separatedBy: ",").first {
                                maxAgeDoubleValue = (maxAge as NSString).doubleValue
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        let image = UIImage(data: newData)
                        completionBlock(image!, maxAgeDoubleValue)
                    }
                }
            }
        }
        task.resume()
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        print ("Method called")

    }
//    func URLSession(session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
//        // println("download task did write data")
//
//        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
//
//        DispatchQueue.main.async() {
//            print (progress)
//        }
//    }
}

