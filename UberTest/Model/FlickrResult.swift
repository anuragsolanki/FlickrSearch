//
//  WikiResult.swift
//  CastleGlobalAssignment
//
//  Created by Anurag Solanki on 16/06/17.
//  Copyright © 2017 Anurag Solanki. All rights reserved.
//

import Foundation
import Alamofire

typealias DownloadImageCompletion = (_ image: UIImage?) -> ()

class FlickrResult {
    
    var thumbnailImageURL: String?
    
    init(thumbnailImageURL: String? = nil) {
        self.thumbnailImageURL = thumbnailImageURL
    }
    
}

