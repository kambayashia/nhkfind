//
//  NowOnAirViewController.swift
//  nhkfind
//
//  Created by atsushi.kambayashi on 2015/01/08.
//  Copyright (c) 2015年 atsushi.kambayashi. All rights reserved.
//

import Foundation
import UIKit

class NowOnAirViewController : UIViewController {
  override func viewDidLoad() {
    self.title = NhkApi.Method.NowOnAir(area: NhkApi.Area.defaultValue(), service: NhkApi.Service.defaultValue()).name
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}