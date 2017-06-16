//
//  HistoryVC.swift
//  UberTest
//
//  Created by Anurag Solanki on 16/06/17.
//  Copyright © 2017 Anurag Solanki. All rights reserved.
//

import UIKit

class HistoryVC: UITableViewController {
    
    var history: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        navigationItem.title = "Search History"

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(HistoryVC.clearHistory))
        
        loadHistory()
    }
    
    func loadHistory() {
        if let allHistory = SearchHistory.getAllSavedHistory(), allHistory.count > 0 {
            history = allHistory
        } else {
            history = []
        }
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func clearHistory() {
        SearchHistory.clearHistory()
        loadHistory()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifier.TableView.historyCell, for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = history[indexPath.row]

        return cell
    }


}
