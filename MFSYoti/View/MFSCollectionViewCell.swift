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
    @IBOutlet weak var progressView: UIActivityIndicatorView!
    @IBOutlet weak var downloadButton: UIButton!


    override func awakeFromNib() {
        super.awakeFromNib()
        downloadButton.layer .makeShadedRounded(withCornerRadius: 5.0, borderColor: UIColor.lightGray)
        downloadButton.layer.borderWidth = 1

    }
    @IBAction func downloadButtonTapped(_ sender: AnyObject) {
        self.progressView.startAnimating()
        self.downloadButton.isHidden = true
        cellDelegate?.downloadButtonTapped(self)
    }
   
    func updateDisplay(image : UIImage) {
        msfImgView.image = image
        self.downloadButton.isHidden = false
        self.progressView.stopAnimating()
    }
}
