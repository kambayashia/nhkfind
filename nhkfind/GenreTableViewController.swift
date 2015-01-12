//
//  GenreTableViewController.swift
//  nhkfind
//
//  Created by atsushi.kambayashi on 2015/01/12.
//  Copyright (c) 2015年 atsushi.kambayashi. All rights reserved.
//

import Foundation
import UIKit

class GenreTableViewController : UITableViewController {
  var previous:UIViewController? = nil
  var current:NhkApi.GenreType? = nil
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    if current != nil {
      let index = NhkApi.GenreType.index(current!)
      tableView.selectRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0), animated: true, scrollPosition: UITableViewScrollPosition.Middle)
    }
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return NhkApi.GenreType.all.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
    cell.textLabel?.text = NhkApi.GenreType.all[indexPath.row].text
    return cell
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let selected = NhkApi.GenreType.all[indexPath.row]
    
    navigationController?.popViewControllerAnimated(true)
    if let controller = previous as? GenreViewController {
      controller.genre = selected
    }
  }
}