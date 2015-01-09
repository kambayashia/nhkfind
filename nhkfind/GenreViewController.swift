//
//  GenreViewController.swift
//  nhkfind
//
//  Created by atsushi.kambayashi on 2015/01/08.
//  Copyright (c) 2015年 atsushi.kambayashi. All rights reserved.
//

import Foundation
import UIKit

class GenreViewController : UIViewController {
  override func viewDidLoad() {
    self.title = NhkApi.Method.Genre(area: NhkApi.Area.defaultValue(), service: NhkApi.Service.defaultValue(), genre: NhkApi.GenreType.defaultValue(), date: "").name
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}