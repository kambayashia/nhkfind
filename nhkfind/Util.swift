//
//  Util.swift
//  nhkfind
//
//  Created by atsushi.kambayashi on 2015/02/14.
//  Copyright (c) 2015年 atsushi.kambayashi. All rights reserved.
//

import Foundation

class Util
{
  class func placeholderImage() -> UIImage {
    return UIImage(named: "nowloading")!
  }
  
  class func formattedProgramPeriod(program:NhkProgram, format:String = "HH:mm") -> String{
    var dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = format
    let period = dateFormatter.stringFromDate(program.startTime) + "〜" + dateFormatter.stringFromDate(program.endTime)
    return period
  }
  
  class func formattedProgramPeriodWithDay(program:NhkProgram) -> String {
    return formattedProgramPeriod(program, format:"MM/dd HH:mm")
  }
  
  class func boldFontName(size:CGFloat) -> UIFont {
    return UIFont(name: "HiraKakuProN-W6", size: size)!
  }
  
  class func normalFontName(size:CGFloat) -> UIFont {
    return UIFont(name: "HiraKakuProN-W3", size: size)!
  }
  
  class func textColor() -> UIColor {
    return UIColor.whiteColor()
  }
}