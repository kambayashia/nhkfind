
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
  @IBOutlet var scrollView: UIScrollView!
  @IBOutlet weak var programImageView: UIImageView!
  @IBOutlet weak var outlineView: UIView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var onAirPeriodLabel: UILabel!
  @IBOutlet weak var areaLabel: UILabel!
  @IBOutlet weak var serviceImageView: UIImageView!
  @IBOutlet weak var descriptionView: UITextView!
  @IBOutlet weak var genreLabel: UILabel!
  @IBOutlet weak var hashTagLabel: UILabel!
  @IBOutlet weak var contentView: UIView!
  
  var detail:NhkProgramDetail? = nil
  var program:NhkProgram? = nil
  
  override func viewDidLoad() {
    loadDetailProgram()
    
    self.title = NhkApi.Method.Info(area: NhkApi.Area.defaultValue(), service: NhkApi.Service.defaultValue(), id: 0).name

    let beforeContentSize = scrollView.contentSize
    let beforeViewSize = contentView.bounds.size
    
    nameLabel.text = program!.title
    areaLabel.text = program!.area.name
    var dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    onAirPeriodLabel.text = dateFormatter.stringFromDate(program!.startTime) + "〜" + dateFormatter.stringFromDate(program!.endTime)
    descriptionView.text = program!.subTitle
    serviceImageView.contentMode = UIViewContentMode.ScaleAspectFit
    serviceImageView.sd_setImageWithURL(NSURL(fileURLWithPath: program!.service.logo_l.url!), placeholderImage: Util.placeholderImage())
    
    makeGenreLabel()
    
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    /*
    outlineView.setNeedsLayout()
    outlineView.layoutIfNeeded()
    contentView.setNeedsLayout()
    contentView.layoutIfNeeded()
*/
    let afterContentSize = scrollView.contentSize
    let afterViewSize = contentView.bounds.size
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func loadDetailProgram() {
    var nhkApi:NhkApi? = nil
    if let keyFilePath =  NSBundle.mainBundle().pathForResource("NhkApiKey", ofType: "txt") {
      let keyData = NSString(contentsOfFile: keyFilePath, encoding: NSUTF8StringEncoding, error: nil)
      nhkApi = NhkApi(apiKey: String(keyData!))
    }
    
    var indicatorView = UIActivityIndicatorView(frame: self.view.frame)
    indicatorView.startAnimating();
    self.view.addSubview(indicatorView)
    
    nhkApi?.request(NhkApi.Method.Info(area: NhkApi.Area(rawValue: program!.area.id)!, service: NhkApi.Service(rawValue: program!.service.id)!, id: program!.id.toInt()!),
      success: {
        (response:JsonDictionary) -> Void in
        weak var wnhkApi = nhkApi
        if let _json = response["list"] as? JsonDictionary {
          for (key, item) in _json {
            if let _arrayItem = item as? [JsonDictionary] {
              self.detail = wnhkApi?.makeProgramDetailFromJson(_arrayItem[0])
              self.makeHashTagLabel()
              let logo = self.detail?.logo?.url ?? self.detail?.program.service.logo_m.url
              self.programImageView.contentMode = UIViewContentMode.ScaleAspectFit
              self.programImageView.sd_setImageWithURL(NSURL(fileURLWithPath: logo!), placeholderImage: Util.placeholderImage())
            }
            break;
          }
        }
        
        indicatorView.stopAnimating();
        indicatorView.removeFromSuperview()
      },
      failure: {
        () -> Void in
        indicatorView.stopAnimating();
        indicatorView.removeFromSuperview()
    }
    )
  }
  
  func makeGenreLabel() {
    var text = ""
    let count = program?.genres.count
    for var i = 0; i < count; i++ {
      let genreValue = program?.genres[i]
      let genre = NhkApi.GenreType(rawValue: genreValue!)
      if !text.isEmpty {
        text += "  "
      }
      text +=  (genre?.text ?? "")
    }
    
    if text.isEmpty {
      genreLabel.text = "その他"
    }
    else {
      genreLabel.text = text
    }
  }
  
  func makeHashTagLabel() {
    var text = ""
    let count = detail!.hashTags.count
    for var i = 0; i < count; i++ {
      let tag = detail!.hashTags[i]
      text += (tag ?? "") + "　"
    }
    
    if text.isEmpty {
      hashTagLabel.text = "ハッシュタグはありません"
    }
    else {
      hashTagLabel.text = text
    }
  }
  
}