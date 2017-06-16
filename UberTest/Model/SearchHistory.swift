//
//  SearchHistory.swift
//  UberTest
//
//  Created by Anurag Solanki on 16/06/17.
//  Copyright © 2017 Anurag Solanki. All rights reserved.
//

import Foundation

class SearchHistory {
    
    static let historyConstant = "history"
    var historyArray: [String]?
    
    
    class func saveToHistory(str: String) {
        let defaults = UserDefaults.standard
        if var historyArr = defaults.array(forKey: historyConstant) as? [String] {
            if historyArr.contains(str) {} else {
                historyArr.append(str)
                defaults.set(historyArr, forKey: historyConstant)
                defaults.synchronize()
            }
        } else {
            defaults.set([str], forKey: historyConstant)
        }
    }
    
    class func getAllSavedHistory() -> [String]? {
        let defaults = UserDefaults.standard
        if let historyArr = defaults.array(forKey: historyConstant) as? [String] {
            return historyArr
        }
        return nil
    }
    
    class func clearHistory() {
        let defaults = UserDefaults.standard
        if defaults.array(forKey: historyConstant) != nil {
            defaults.removeObject(forKey: historyConstant)
            defaults.synchronize()
        }
    }
    
}
