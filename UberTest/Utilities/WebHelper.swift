//
//  WebHelper.swift
//  CastleGlobalAssignment
//
//  Created by Anurag Solanki on 16/06/17.
//  Copyright © 2017 Anurag Solanki. All rights reserved.
//

import Foundation
import Alamofire

typealias ResultCompletion = ([FlickrResult]) -> ()

final class WebHelper {
    
    // To ensure creation of single instance
    fileprivate init() {}

    static let sharedInstance = WebHelper()
    
    
    func loadResults(queryString: String, pageNo: String, completion: @escaping ResultCompletion) {
        let requestURL = "\(Constants.URL.apiBaseURL)"
        let params = ["method": "flickr.photos.search", "api_key" : Constants.Keys.flickrAPIKey, "format": "json", "nojsoncallback": "1", "safe_search": "1", "text": queryString, "page": pageNo]
        
        Alamofire.request(requestURL, parameters: params).responseJSON{ response in
            print(response.result)
            
            guard let JSON = response.result.value else {
                completion([])
                return
            }
            guard let result = (JSON as! [String: AnyObject])["photos"]?["photo"] else {
                completion([])
                return
            }
            guard let photo = result as? [[String: AnyObject]] else {
                completion([])
                return
            }
            
            var entries: [FlickrResult] = []
            for dict in photo {
                
                // Save result with image
                if let farm = dict["farm"] as? Int, let server = dict["server"] as? String, let pId = dict["id"] as? String, let secret = dict["secret"] as? String {
                    let entry = FlickrResult(thumbnailImageURL: "https://farm\(farm).static.flickr.com/\(server)/\(pId)_\(secret).jpg")
                    entries.append(entry)
                    continue
                }
            }

            completion(entries)
        }
    }
}
