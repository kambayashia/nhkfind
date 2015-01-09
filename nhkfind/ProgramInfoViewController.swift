//
//  ProgramInfoViewController.swift
//  nhkfind
//
//  Created by atsushi.kambayashi on 2015/01/08.
//  Copyright (c) 2015年 atsushi.kambayashi. All rights reserved.
//

import Foundation
import UIKit

class ProgramInfoViewController : UIViewController {
  override func viewDidLoad() {
    self.title = NhkApi.Method.Info(area: NhkApi.Area.defaultValue(), service: NhkApi.Service.defaultValue(), id: 0).name
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}