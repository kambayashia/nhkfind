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
  var programList:[NhkProgram] = []
  var selected:Int = 0
  let cellIdentifier = "CellIdentifier"

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
  
    tableView.tableFooterView = UIView(frame: CGRectZero)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let controller = segue.destinationViewController as? ProgramInfoViewController {
      controller.program = programList[selected]
    }
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let program = programList[indexPath.row]
    var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
    cell?.textLabel?.text = program.title
    cell?.detailTextLabel?.text = program.subTitle
    
    if let imageUrl = program.service.logo_s.url {
      cell?.imageView?.sd_setImageWithURL(
        NSURL(string: imageUrl),
        placeholderImage: nil
      )
    }
    return cell!
  }
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return programList.count
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    selected = indexPath.row
    
    performSegueWithIdentifier("ShowProgramInfo", sender: nil)
  }
}