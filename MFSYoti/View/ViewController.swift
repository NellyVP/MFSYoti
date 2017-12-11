//
//  ViewController.swift
//  MFSYoti
//
//  Created by Nilofar Vahab poor on 03/12/2017.
//  Copyright © 2017 Nilofar Vahab poor. All rights reserved.
//

import UIKit
private let reuseIdentifier = "MFSCollectionViewCell"

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    let controller = MFSController()
    var arrayOfPics = [UIImage]()
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        DownloadManager.shared.onProgress = nil
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        downloadButtonTapped(collectionView.cellForItem(at: IndexPath.init(item: 0, section: 0)) as! MFSCollectionViewCell)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return controller.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MFSCollectionViewCell
        cell.cellDelegate = self
        return cell
    }
}
extension ViewController: MFSCollectionViewCellDelegate {
    func downloadButtonTapped(_ cell: MFSCollectionViewCell) {
        if let indexPath = collectionView.indexPath(for: cell) {
            if let image = CacheOrganiser.sharedCache.findImageFromCache(urlString: String().md5(controller.images[(indexPath.row)])) {
                cell.updateDisplay(image: UIImage(data: image.imageData! as Data)!)
            }
            else {
                controller.getImage(imageId:controller.images[(indexPath.row)]) { (image) in
                    DispatchQueue.main.async {
                        cell.updateDisplay(image: image!)
                    }
                }
            }
        }
    }
}


