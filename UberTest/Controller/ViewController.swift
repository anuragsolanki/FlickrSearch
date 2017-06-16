//
//  ViewController.swift
//  UberTest
//
//  Created by Anurag Solanki on 16/06/17.
//  Copyright © 2017 Anurag Solanki. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var searchField = UISearchBar()
    var resultArray: [FlickrResult] = []
    var currentPage = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        collectionView.keyboardDismissMode = .interactive
        
        self.searchField.translatesAutoresizingMaskIntoConstraints = false
        self.searchField.searchBarStyle = .minimal
        self.searchField.delegate = self
        navigationItem.titleView = searchField

        let button1 = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(ViewController.showHistory))
        self.navigationItem.rightBarButtonItem  = button1
    }

    // MARK:- Search Bar Delegate Methods
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchField.resignFirstResponder()
        if let txt = searchField.text {
            collectionView.setContentOffset(CGPoint.zero, animated: false)
            currentPage = 1
            searchForResultWith(text: txt)
            SearchHistory.saveToHistory(str: txt)
        }
    }
/*
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        currentPage = 1
        searchForResultWith(text: searchText)
    }
 */

    
    func searchForResultWith(text searchText: String) {
        // Make an API Call and refresh the entries based on the text
        WebHelper.sharedInstance.loadResults(queryString: searchText, pageNo: "\(currentPage)", completion: { [weak self]
            (entries) in
            if self?.currentPage == 1 {
                self?.resultArray = []
            }
            self?.resultArray.append(contentsOf: entries)
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        })
    }
    
    // MARK: Show history screen
    func showHistory() {
        let historyVC = storyboard?.instantiateViewController(withIdentifier: "HistoryVC") as! HistoryVC
        navigationController?.pushViewController(historyVC, animated: true)
    }

}


extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultArray.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifier.CollectionView.cell, for: indexPath as IndexPath) as! MyCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.initializeWithResult(result: resultArray[indexPath.row])
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (UIScreen.main.bounds.width-40)/3        // (Screenwidth - padding) /3
        return CGSize(width: itemSize, height:itemSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FooterView", for: indexPath)
            return footerView
        default:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FooterView", for: indexPath)
            return footerView
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        let spinner = view.viewWithTag(99) as! UIActivityIndicatorView
        if resultArray.count <= 0 {
            spinner.stopAnimating()
        } else {
            spinner.startAnimating()
            if let txt = searchField.text {
                currentPage = currentPage + 1
                searchForResultWith(text: txt)
            }
        }
    }

    

}

