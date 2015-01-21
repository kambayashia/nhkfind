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
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var programImageView: UIImageView!
  @IBOutlet weak var outlineView: UIView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var onAirPeriodLabel: UILabel!
  @IBOutlet weak var areaLabel: UILabel!
  @IBOutlet weak var serviceImageView: UIImageView!
  @IBOutlet weak var descriptionView: UITextView!
  @IBOutlet weak var genreLabel: UILabel!
  @IBOutlet weak var hashTagLabel: UILabel!
  
  
  var program:NhkProgram? = nil
  
  override func viewDidLoad() {
    self.title = NhkApi.Method.Info(area: NhkApi.Area.defaultValue(), service: NhkApi.Service.defaultValue(), id: 0).name
    
    nameLabel.text = program!.title
    areaLabel.text = program!.area.name
    descriptionView.text = program!.subTitle
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}