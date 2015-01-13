//
//  ViewController.swift
//  nhkfind
//
//  Created by atsushi.kambayashi on 2015/01/05.
//  Copyright (c) 2015年 atsushi.kambayashi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  @IBOutlet weak var menuTableView: UITableView!

  let texts = [
    NhkApi.Method.List(area: NhkApi.Area.defaultValue(), service: NhkApi.Service.defaultValue(), date: ""),
    NhkApi.Method.Genre(area: NhkApi.Area.defaultValue(), service: NhkApi.Service.defaultValue(), genre: NhkApi.GenreType.defaultValue(), date: ""),
    NhkApi.Method.NowOnAir(area: NhkApi.Area.defaultValue(), service: NhkApi.Service.defaultValue())
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    menuTableView.dataSource = self
    menuTableView.delegate = self
    
    self.title = "メニュー"
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    menuTableView.tableFooterView = UIView(frame: CGRectZero)
    //menuTableView.contentInset = UIEdgeInsets(top: -1, left: 0, bottom: 0, right: 0)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return texts.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: nil)
    
    cell.textLabel?.text = texts[indexPath.row].name
    cell.textLabel?.textColor = UIColor.whiteColor()
    cell.backgroundColor = UIColor.grayColor()
    cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator

    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
    let method = texts[indexPath.row]
    var segueName : String = ""
    switch method {
    case NhkApi.Method.List: segueName = "ShowProgramList"
    case NhkApi.Method.Genre: segueName = "ShowGenre"
    case NhkApi.Method.NowOnAir: segueName = "ShowNowOnAir"
    default: break
    }
    
    performSegueWithIdentifier(segueName, sender: nil)
  }
}

