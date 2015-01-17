//
//  ServiceTableViewController.swift
//  nhkfind
//
//  Created by atsushi.kambayashi on 2015/01/12.
//  Copyright (c) 2015年 atsushi.kambayashi. All rights reserved.
//

import Foundation
import UIKit

class ServiceTableViewController : UITableViewController {
  var previous:UIViewController? = nil
  var current:NhkApi.Service? = nil

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    if current != nil {
      let index = NhkApi.Service.index(current!)
      tableView.selectRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0), animated: true, scrollPosition: UITableViewScrollPosition.Middle)
    }
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return NhkApi.Service.all.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let all = NhkApi.Service.all
    var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
    cell.textLabel?.text = all[indexPath.row].text
    
    return cell
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let selected = NhkApi.Service.all[indexPath.row]
    
    navigationController?.popViewControllerAnimated(true)
    if let controller = previous as? GenreViewController {
      controller.service = selected
    }
    else if let controller = previous as? ProgramListViewController {
      controller.service = selected
    }
    else if let controller = previous as? NowOnAirViewController {
      controller.service = selected
    }
  }
}