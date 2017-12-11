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
    typealias downloadCompletionHandler = (UIImage?, HTTPURLResponse, Error?) -> ()

    var onProgress : ProgressHandler? {
        didSet {
            if onProgress != nil {
                let _ = activate()
            }
        }
    }
    private var error:Error? = nil
    
    var onCompletionHandler: downloadCompletionHandler? {
        didSet {
            if onCompletionHandler != nil {
                let _ = activate()
            }
        }
    }
    
    override public init() {
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
    private func getImage(imageData : NSData, httpResponse: HTTPURLResponse, completionHandler : @escaping (UIImage?, HTTPURLResponse, Error?) -> ()) {
        let image = UIImage(data: imageData as Data)
        completionHandler(image!, httpResponse, error)
    }
    
    //Delegate methods
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        if totalBytesExpectedToWrite > 0 {
            if let onProgress = onProgress {
                calculateProgress(session: session, completionHandler: onProgress)
            }
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
                let returnedData = NSData(contentsOf: location)
                getImage(imageData: returnedData!, httpResponse: httpResponse, completionHandler:completion)
            }
            try? FileManager.default.removeItem(at: location)
        }
    }
    

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        self.error = error
        debugPrint("Download Task completed: \(task), error: \(String(describing: error))")
    }
    
}


