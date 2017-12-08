//
//  MFSCollectionViewCell.swift
//  MFSYoti
//
//  Created by Nilofar Vahab poor on 05/12/2017.
//  Copyright © 2017 Nilofar Vahab poor. All rights reserved.
//

import UIKit

protocol MFSCollectionViewCellDelegate {
    func downloadButtonTapped(_ cell: MFSCollectionViewCell)
}


class MFSCollectionViewCell: UICollectionViewCell {
    var cellDelegate: MFSCollectionViewCellDelegate?
    @IBOutlet weak var msfImgView: UIImageView!
    @IBOutlet weak var activityIdicator: UIActivityIndicatorView!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!

    override func awakeFromNib() {
        super.awakeFromNib()
        downloadButton.layer .makeShadedRounded(withCornerRadius: 5.0, borderColor: UIColor.lightGray)
        downloadButton.layer.borderWidth = 1
        updateProgessbar(progress: 0.0)
        progressView.isHidden = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        msfImgView.image = nil
//        downloadButton.isHidden = false
//        progressView.isHidden = true
    }
    
    @IBAction func downloadButtonTapped(_ sender: AnyObject) {
        activityIdicator.startAnimating()
        downloadButton.isHidden = true
        progressView.isHidden = false
        cellDelegate?.downloadButtonTapped(self)
        DownloadManager.shared.onProgress = { (progress) in
            OperationQueue.main.addOperation {
                self.updateProgessbar(progress: progress)
            }
        }
    }
   
    func updateProgessbar(progress: Float) {
        progressView.setProgress(progress, animated: true)
        progressView.setNeedsDisplay()
    }
    
    func updateDisplay(image : UIImage) {
        msfImgView.image = image
        downloadButton.isHidden = false
        progressView.isHidden = true
        updateProgessbar(progress: 0.0)
        activityIdicator.stopAnimating()
    }
}
