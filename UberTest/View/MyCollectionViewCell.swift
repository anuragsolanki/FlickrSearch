//
//  MyCollectionViewCell.swift
//  CastleGlobalAssignment
//
//  Created by Anurag Solanki on 16/06/17.
//  Copyright © 2017 Anurag Solanki. All rights reserved.
//

import UIKit
import SDWebImage

class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!

    func initializeWithResult(result: FlickrResult) {
        if let imageUrl = result.thumbnailImageURL {
            // Download image in Background thread
            thumbnail.sd_setImage(with: URL(string: imageUrl))
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        thumbnail.image = nil
    }
    
}
