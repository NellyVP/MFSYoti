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
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //download the first image.
        let indexPathForFirstRow = NSIndexPath(item: 0, section: 0)
        self.downloadButtonTapped(self.collectionView.cellForItem(at: indexPathForFirstRow as IndexPath) as! MFSCollectionViewCell)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
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
            controller.getImage(imageId: controller.images[(indexPath.row)]) { (image) in
                cell.updateDisplay(image: image!)
                cell.msfImgView.image = image
            }
        }
    }

}


