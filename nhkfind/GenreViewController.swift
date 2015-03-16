//
//  GenreViewController.swift
//  nhkfind
//
//  Created by atsushi.kambayashi on 2015/01/08.
//  Copyright (c) 2015年 atsushi.kambayashi. All rights reserved.
//

import Foundation
import UIKit

class GenreViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
  @IBOutlet weak var areaTableView: UITableView!
  @IBOutlet weak var serviceTableView: UITableView!
  @IBOutlet weak var genreTableView: UITableView!
  @IBOutlet weak var dateSegmentedControl: UISegmentedControl!
  @IBOutlet weak var searchButton: UIButton!
  
  var area = NhkApi.Area.defaultValue()
  var service = NhkApi.Service.defaultValue()
  var genre = NhkApi.GenreType.defaultValue()
  var selectedDate:String = ""
  var programList:[NhkProgram] = []
  var nhkApi:NhkApi? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let keyFilePath =  NSBundle.mainBundle().pathForResource("NhkApiKey", ofType: "txt") {
      let keyData = NSString(contentsOfFile: keyFilePath, encoding: NSUTF8StringEncoding, error: nil)
      nhkApi = NhkApi(apiKey: String(keyData!))
    }
    
    let availableDate = NhkApi.availableDate
    selectedDate = availableDate.0
    dateSegmentedControl.setTitle(availableDate.0, forSegmentAtIndex: 0)
    dateSegmentedControl.setTitle(availableDate.1, forSegmentAtIndex: 1)
    
    self.title = "ジャンル"
    
    areaTableView.delegate = self
    areaTableView.dataSource = self
    serviceTableView.delegate = self
    serviceTableView.dataSource = self
    genreTableView.delegate = self
    genreTableView.dataSource = self
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
  
    areaTableView.reloadData()
    serviceTableView.reloadData()
    genreTableView.reloadData()
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
      controller.current = genre
      controller.previous = self
    }
    else if let controller = segue.destinationViewController as? ServiceTableViewController {
      controller.current = service
      controller.previous = self
    }
    else if let controller = segue.destinationViewController as? SearchResultViewController {
      controller.programList = self.programList
      self.programList = []
    }

  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
    cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
    if tableView == areaTableView {
      cell.textLabel?.text = area.text
    }
    else if tableView == serviceTableView {
      cell.textLabel?.text = service.text
    }
    else {
      cell.textLabel?.text = genre.text
    }
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: false)
    
    var segueName:String? = nil
    switch tableView {
    case areaTableView: segueName = "ShowAreaTable"
    case serviceTableView: segueName = "ShowServiceTable"
    case genreTableView: segueName = "ShowGenreTable"
    default: break
    }
    
    if segueName != nil {
      performSegueWithIdentifier(segueName, sender: nil)
    }
  }
  
  @IBAction func dateChanged(sender: UISegmentedControl) {
    selectedDate = dateSegmentedControl.titleForSegmentAtIndex(dateSegmentedControl.selectedSegmentIndex)!
  }
  @IBAction func request(sender: UIButton) {
    searchButton.enabled = false
    
    let date = selectedDate
    let method = NhkApi.Method.Genre(area: area, service: service, genre: genre, date: selectedDate)
    nhkApi?.request(method,
      success: {
        [unowned self]
        (jsonDictionary:JsonDictionary) -> Void in
        weak var wnhkApi:NhkApi? = self.nhkApi
      
        self.searchButton.enabled = true

        if let _jsonDictionary = jsonDictionary["list"] as? JsonDictionary {
          var programList:[NhkProgram] = []
          for (serviceName, programListJson) in _jsonDictionary  {
            if let jsonProgramList = programListJson as? [JsonDictionary] {
              for var i:Int = 0; i < jsonProgramList.count; i++ {
                let program = wnhkApi!.makeProgramFromJson(jsonProgramList[i])
                programList.append(program)
              }
            }
          }
          self.programList = programList
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
}