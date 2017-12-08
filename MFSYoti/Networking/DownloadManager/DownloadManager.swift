//
//  DownloadManager.swift
//  MFSYoti
//
//  Created by Nilofar Vahab poor on 08/12/2017.
//  Copyright © 2017 Nilofar Vahab poor. All rights reserved.
//

import UIKit

class DownloadManager : NSObject, URLSessionDelegate, URLSessionDownloadDelegate {
    
    static var shared = DownloadManager()
    
    typealias ProgressHandler = (Float) -> ()
    typealias downloadCompletionHandler = (UIImage, HTTPURLResponse) -> ()

    var onProgress : ProgressHandler? {
        didSet {
            if onProgress != nil {
                let _ = activate()
            }
        }
    }
    
    var onCompletionHandler: downloadCompletionHandler? {
        didSet {

        }
    }
    
    override private init() {
        super.init()
    }
    
    func activate() -> URLSession {
        let config = URLSessionConfiguration.background(withIdentifier: "\(Bundle.main.bundleIdentifier!).background")
        return URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue())
    }
    
    private func calculateProgress(session : URLSession, completionHandler : @escaping (Float) -> ()) {
        session.getTasksWithCompletionHandler { (tasks, uploads, downloads) in
            let progress = downloads.map({ (task) -> Float in
                if task.countOfBytesExpectedToReceive > 0 {
                    return Float(task.countOfBytesReceived) / Float(task.countOfBytesExpectedToReceive)
                } else {
                    return 0.0
                }
            })
            completionHandler(progress.reduce(0.0, +))
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        if totalBytesExpectedToWrite > 0 {
            if let onProgress = onProgress {
                calculateProgress(session: session, completionHandler: onProgress)
            }
//            let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
            //debugPrint("Progress \(downloadTask) \(progress)")
            
        }
    }
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask,
                    didFinishDownloadingTo location: URL) {
        guard let httpResponse = downloadTask.response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
                print ("server error")
                return
        }
        do {
            if let completion = onCompletionHandler {
                getImage(url: location, httpResponse: httpResponse, completionHandler:completion)
            }
            try? FileManager.default.removeItem(at: location)
        }
    }
    
    private func getImage(url : URL, httpResponse: HTTPURLResponse, completionHandler : @escaping (UIImage, HTTPURLResponse) -> ()) {
        let imageData:NSData = NSData(contentsOf: url)!
        let image = UIImage(data: imageData as Data)
        completionHandler(image!, httpResponse)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        //debugPrint("Task completed: \(task), error: \(String(describing: error))")
    }
    
}


