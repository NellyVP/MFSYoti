//
//  ViewController.swift
//  MFSYoti
//
//  Created by Nilofar Vahab poor on 03/12/2017.
//  Copyright © 2017 Nilofar Vahab poor. All rights reserved.
//

import UIKit
private let reuseIdentifier = "SlideShowCustomCollectionViewCell"

protocol MFSCustomCellDelegate: class {
    func downloadImage(_ cell: MFSCustomCell?)
}

class MFSCustomCell: UICollectionViewCell {
    @IBOutlet var imgView:UIImageView!
    weak var delegate: MFSCustomCellDelegate?

}

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, MFSCustomCellDelegate {
    let controller = MFSController()
    @IBOutlet var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let indexPathForFirstRow = NSIndexPath(item: 0, section: 0)
        self.downloadImage(self.collectionView .cellForItem(at: indexPathForFirstRow as IndexPath) as? MFSCustomCell)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return controller.images.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height:380)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MFSCustomCell
        cell.delegate = self
    
        return cell
    }

    func downloadImage(_ cell: MFSCustomCell?) {
        if ((cell?.imgView.image) != nil) {
            cell?.imgView.image = nil
        }
        let indexPath = collectionView.indexPath(for: cell!)
        controller.getImage(imageId: controller.images[(indexPath?.row)!]) { (image) in
            cell?.imgView.image = image
            self.collectionView.reloadData()
        }}
}

