//
//  ResultsTableViewController.swift
//  Monkey Puzzle
//
//  Created by Simon on 20/08/2015.
//  Copyright © 2015 Simon Whitaker. All rights reserved.
//

import SafariServices
import UIKit

class ResultsTableViewController: UITableViewController {

  static let cellIdentifier = "CellId"
  
  var words = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: ResultsTableViewController.cellIdentifier)
  }
  
  // MARK: - Table view data source
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return words.count
  }
  
  override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if words.count == 1 {
      return "1 result"
    }
    return "\(words.count) results"
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(ResultsTableViewController.cellIdentifier, forIndexPath: indexPath)
    cell.textLabel?.text = words[indexPath.row]
    return cell
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let urlString = "http://www.onelook.com/?w=" + words[indexPath.row].stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())!
    let vc = SFSafariViewController(URL: NSURL(string: urlString)!)
    presentViewController(vc, animated: true, completion: nil)
  }
}
