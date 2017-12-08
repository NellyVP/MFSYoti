//
//  MFSRequest.swift
//  MyFirstSlideshow
//
//  Created by Nilofar Vahab poor on 18/10/2017.
//  Copyright © 2017 Yoti. All rights reserved.
//

import Foundation
import UIKit

class MFSRequest: NSObject{
    var modelFactory = ModelFactory()
    
    func fetchImage(urlStr: String, completionBlock: @escaping (MFSImage?) -> Void)  {
        let url = URL(string: urlStr)!
        let request = URLRequest(url:url as URL)
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error == nil {
                completionBlock(self.modelFactory.createImageFrom(urlString: urlStr, data: data!, response: response as! HTTPURLResponse))
                }
            }
        task.resume()
    }
}

