//
//  AreaTableViewController.swift
//  nhkfind
//
//  Created by atsushi.kambayashi on 2015/01/12.
//  Copyright (c) 2015年 atsushi.kambayashi. All rights reserved.
//

import Foundation
import UIKit

class AreaTableViewContorller : UITableViewController {
  var current:NhkApi.Area? = nil
  var previous:UIViewController? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "地域選択"
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    if current != nil {
      let index = NhkApi.Area.index(current!)
      tableView.selectRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0), animated: true, scrollPosition: UITableViewScrollPosition.Middle)
    }
  }
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return NhkApi.Area.all.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let all = NhkApi.Area.all
    var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
    cell.textLabel?.text = all[indexPath.row].text
    
    return cell
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let selected = NhkApi.Area.all[indexPath.row]

    navigationController?.popViewControllerAnimated(true)
    if let controller = previous as? GenreViewController {
      controller.area = selected
    }
    else if let controller = previous as? ProgramListViewController {
      controller.area = selected
    }
    else if let controller = previous as? NowOnAirViewController {
      
    }
  }
}