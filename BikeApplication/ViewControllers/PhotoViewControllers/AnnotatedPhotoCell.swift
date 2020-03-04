//
//  AnnotatedPhotoCell.swift
//  BikeApplication
//
//  Created by Sam Perry on 03/03/2020.
//  Copyright © 2020 Sam Perry. All rights reserved.
//


import UIKit
class AnnotatedPhotoCell: UICollectionViewCell {
  @IBOutlet private weak var containerView: UIView!
  @IBOutlet private weak var imageView: UIImageView!
  @IBOutlet private weak var captionLabel: UILabel!
  @IBOutlet private weak var commentLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    containerView.layer.cornerRadius = 6
    containerView.layer.masksToBounds = true
  }
  
  var photo: Photo? {
    didSet {
      if let photo = photo {
        imageView.image = photo.image
        captionLabel.text = photo.caption
        commentLabel.text = photo.comment
      }
    }
  }
}
