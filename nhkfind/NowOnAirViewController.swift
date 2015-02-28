//
//  NowOnAirViewController.swift
//  nhkfind
//
//  Created by atsushi.kambayashi on 2015/01/08.
//  Copyright (c) 2015年 atsushi.kambayashi. All rights reserved.
//

import Foundation
import UIKit

class NowOnAirViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
  @IBOutlet weak var areaTableView: UITableView!
  @IBOutlet weak var serviceTableView: UITableView!
  @IBOutlet weak var searchButton: UIButton!
  
  var area = NhkApi.Area.defaultValue()
  var service = NhkApi.Service.defaultValue()
  var nhkApi:NhkApi? = nil
  var nowOnAirList:[NhkNowOnAir] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    if let keyFilePath =  NSBundle.mainBundle().pathForResource("NhkApiKey", ofType: "txt") {
      let keyData = NSString(contentsOfFile: keyFilePath, encoding: NSUTF8StringEncoding, error: nil)
      nhkApi = NhkApi(apiKey: String(keyData!))
    }
    
    self.title = NhkApi.Method.NowOnAir(area: area, service: service).name
    
    areaTableView.delegate = self
    areaTableView.dataSource = self
    serviceTableView.delegate = self
    serviceTableView.dataSource = self
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    areaTableView.reloadData()
    serviceTableView.reloadData()
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let controller = segue.destinationViewController as? AreaTableViewContorller {
      controller.current = area
      controller.previous = self
    }
    else if let controller = segue.destinationViewController as? GenreTableViewController {
      controller.previous = self
    }
    else if let controller = segue.destinationViewController as? ServiceTableViewController {
      controller.current = service
      controller.previous = self
    }
    else if let controller = segue.destinationViewController as? SearchResultViewController {
      var programList:[NhkProgram] = []
      for item in self.nowOnAirList {
        if let program = item.previous {
          programList.append(program)
        }
        /*
        if let progmam = item.present {
          programList.append(program)
        }
        */
        programList.append(item.present)
        if let program = item.following {
          programList.append(program)
        }
      }
      
      controller.programList = programList
    }
  }
  
  @IBAction func request(sender: UIButton) {
    searchButton.enabled = false
    
    let method = NhkApi.Method.NowOnAir(area: area, service: service)
    nhkApi?.request(method,
      success: {
        [unowned self]
        (jsonDictionary:JsonDictionary) -> Void in
        weak var wnhkApi:NhkApi? = self.nhkApi
        
        self.searchButton.enabled = true
        
        if let _jsonDictionary = jsonDictionary["nowonair_list"] as? JsonDictionary {
          var programList:[NhkProgram] = []
          for (serviceName, programListJson) in _jsonDictionary  {
            if let jsonProgramList = programListJson as? JsonDictionary {
              let nowOnAir = wnhkApi!.makeNowOnAirFromJson(jsonProgramList)
              self.nowOnAirList.append(nowOnAir)
            }
          }
          self.performSegueWithIdentifier("ShowSearchResult", sender: nil)
        }
      },
      failure: {
        [unowned self]
        () -> Void in
        self.searchButton.enabled = true
      }
    )
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
    cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
    if tableView == areaTableView {
      cell.textLabel?.text = area.text
    }
    else {
      cell.textLabel?.text = service.text
    }
    
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: false)
    
    var segueName:String? = nil
    switch tableView {
    case areaTableView: segueName = "ShowAreaTable"
    case serviceTableView: segueName = "ShowServiceTable"
    default: break
    }
    
    if segueName != nil {
      performSegueWithIdentifier(segueName, sender: nil)
    }
  }
}