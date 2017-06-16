//
//  Constants.swift
//  CastleGlobalAssignment
//
//  Created by Anurag Solanki on 16/06/17.
//  Copyright © 2017 Anurag Solanki. All rights reserved.
//

import Foundation

@objc class Constants: NSObject {
    
    struct Identifier {
        
        struct ViewController {
            static let detail       = "DetailVC"
        }
        
        struct TableView {
            static let cell         = "ResultsCell"
            static let historyCell  = "HistoryCell"
        }
        
        struct CollectionView {
            static let cell         = "CollectionCell"
        }
    }
    
    struct URL {
        static let apiBaseURL       = "https://api.flickr.com/services/rest/"
    }
    
    struct Keys {
        static let flickrAPIKey     = "3e7cc266ae2b0e0d78e279ce8e361736"
    }
    
    
}
