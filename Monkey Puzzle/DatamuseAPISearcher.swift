//
//  DatamuseAPISearcher.swift
//  Monkey Puzzle
//
//  Created by Simon on 20/08/2015.
//  Copyright © 2015 Simon Whitaker. All rights reserved.
//

import UIKit

class DatamuseAPISearcher: NSObject {
  
  // Increments with each search, ensures only the latest search results are sent back to the caller
  private var searchIndex = 0
  private let session: NSURLSession
  
  override init() {
    session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
  }
  
  func fetchResults(searchText: String, completion: (results: [String]) -> ()) {
    if searchText.isEmpty {
      return
    }
    
    let urlString = "https://api.datamuse.com/words?sp=" + searchText.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
    let url = NSURL(string: urlString)
    let task = session.dataTaskWithURL(url!) { (data, response, error) -> Void in
      if let httpResponse = response as! NSHTTPURLResponse? {
        if httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299 && data != nil {
          do {
            let options = NSJSONReadingOptions(rawValue: 0)
            let results = try NSJSONSerialization.JSONObjectWithData(data!, options: options)
            
            let words = results.valueForKeyPath("word") as! [String]
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
              completion(results: words)
            })
          } catch {
            
          }
        }
      }
    }
    task.resume()
  }
}
