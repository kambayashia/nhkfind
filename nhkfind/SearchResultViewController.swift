//
//  SearchResultViewController.swift
//  nhkfind
//
//  Created by atsushi.kambayashi on 2015/01/13.
//  Copyright (c) 2015年 atsushi.kambayashi. All rights reserved.
//

import Foundation
import UIKit

class SearchResultViewController : UITableViewController {
  var area:NhkApi.Area? = nil
  var service:NhkApi.Service? = nil
  var genre:NhkApi.GenreType? = nil
  let cellIdentifier = "CellIdentifier"

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
  
    tableView.tableFooterView = UIView(frame: CGRectZero)
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    //var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier:cellIdentifier)
    var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
    cell?.textLabel?.text = "hoge"
    cell?.detailTextLabel?.text = "detail"
    
    return cell!
  }
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
}