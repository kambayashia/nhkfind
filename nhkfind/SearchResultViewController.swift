//
//  SearchResultViewController.swift
//  nhkfind
//
//  Created by atsushi.kambayashi on 2015/01/13.
//  Copyright (c) 2015年 atsushi.kambayashi. All rights reserved.
//

import Foundation
import UIKit

class SearchResultTableViewCell : UITableViewCell {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var channelLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var logoImageView: UIImageView!
}

class SearchResultViewController : UITableViewController {
  var area:NhkApi.Area? = nil
  var service:NhkApi.Service? = nil
  var genre:NhkApi.GenreType? = nil
  var programList:[NhkProgram] = []
  var selected:Int = 0
  let cellIdentifier = "CellIdentifier"

  override func viewDidLoad() {
      super.viewDidLoad()
    
      self.title = "検索結果"
  }
  
  
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
    var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? SearchResultTableViewCell

    cell?.titleLabel.text = program.title
    cell?.channelLabel.text = program.service.name
    cell?.dateLabel.text = Util.formattedProgramPeriodWithDay(program)
    if let imageUrl = program.service.logo_s.url {
      cell?.logoImageView.sd_setImageWithURL(
        NSURL(string: imageUrl),
        placeholderImage: Util.placeholderImage()
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