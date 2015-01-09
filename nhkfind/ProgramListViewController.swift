//
//  ProgramListViewController.swift
//  nhkfind
//
//  Created by atsushi.kambayashi on 2015/01/07.
//  Copyright (c) 2015年 atsushi.kambayashi. All rights reserved.
//

import Foundation
import UIKit

class ProgramListViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
  @IBOutlet weak var pickerView: UIPickerView!
  @IBOutlet weak var dateSegmentedControl: UISegmentedControl!
  var selectedArea:NhkApi.Area = NhkApi.Area.defaultValue()
  var selectedService:NhkApi.Service = NhkApi.Service.defaultValue()
  var selectedDate:String = ""
  var nhkApi:NhkApi? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    if let keyFilePath =  NSBundle.mainBundle().pathForResource("NhkApiKey", ofType: "txt") {
      let keyData = NSString(contentsOfFile: keyFilePath, encoding: NSUTF8StringEncoding, error: nil)
      nhkApi = NhkApi(apiKey: String(keyData!))
    }
    
    self.title = NhkApi.Method.List(area: NhkApi.Area.defaultValue(), service: NhkApi.Service.defaultValue(), date: "").name
    
    pickerView.delegate = self
    pickerView.dataSource = self
    
    let availableDate = NhkApi.availableDate
    selectedDate = availableDate.0
    dateSegmentedControl.setTitle(availableDate.0, forSegmentAtIndex: 0)
    dateSegmentedControl.setTitle(availableDate.1, forSegmentAtIndex: 1)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  }
  
  @IBAction func request(sender: UIButton) {
    
    let area = selectedArea
    let service = selectedService
    let date = selectedDate
    let method = NhkApi.Method.List(area: area, service: service, date: date)
    nhkApi?.request(method)
  }
  
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 2
  }
  
  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if component == 0 {
      return NhkApi.Area.all.count
    }
    else {
      return NhkApi.Service.all.count
    }
  }
  
  func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
    if component == 0 {
      let displayArea = NhkApi.Area.all[row]
      return displayArea.text
    }
    else{
      let displayService = NhkApi.Service.all[row]
      return displayService.text
    }
  }
  func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if component == 0 {
      selectedArea = NhkApi.Area.all[row]
    }
    else {
      selectedService = NhkApi.Service.all[row]
    }
  }
  
  @IBAction func dateChanged(sender: UISegmentedControl) {
    selectedDate = dateSegmentedControl.titleForSegmentAtIndex(dateSegmentedControl.selectedSegmentIndex)!
  }
}
