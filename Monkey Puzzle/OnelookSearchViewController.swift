//
//  OnelookSearchViewController.swift
//  Monkey Puzzle
//
//  Created by Simon on 20/08/2015.
//  Copyright © 2015 Simon Whitaker. All rights reserved.
//

import UIKit

class OnelookSearchViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
  
  static let cellIdentifier = "CellId"
  
  var searchController: UISearchController!
  var resultsController: ResultsTableViewController!
  var wordSearcher: DatamuseAPISearcher!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Word Search"
    
    tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: OnelookSearchViewController.cellIdentifier)
    
    wordSearcher = DatamuseAPISearcher()
    
    resultsController = ResultsTableViewController()
    
    searchController = UISearchController(searchResultsController: resultsController)
    searchController.searchResultsUpdater = self
    searchController.searchBar.sizeToFit()
    tableView.tableHeaderView = searchController.searchBar
    
    searchController.delegate = self
    searchController.searchBar.delegate = self
  }
  
  // MARK: - Table view data source
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  // MARK: - UISearchBarDelegate
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
  }
  
  // MARK: - UISearchResultsUpdating
  
  func updateSearchResultsForSearchController(searchController: UISearchController) {
    guard let text = searchController.searchBar.text else { return }
    if (text.isEmpty) {
      resultsController.words = []
      resultsController.tableView.reloadData()
    } else {
      // TODO: add short delay, cancel any existing queries still queued waiting for their delay to expire
      // Send text to Datamuse API
      self.wordSearcher.fetchResults(text, completion: { (searchText, results) -> () in
        // If these are stale results, discard them
        if searchText != searchController.searchBar.text {
          return
        }
        let resultsController = searchController.searchResultsController as! ResultsTableViewController
        resultsController.words = results
        resultsController.tableView.reloadData()
      })
    }
  }
}
