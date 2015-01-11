//
//  NhkApi.swift
//  nhkfind
//
//  Created by atsushi.kambayashi on 2015/01/05.
//  Copyright (c) 2015年 atsushi.kambayashi. All rights reserved.
//

import Foundation
import Alamofire

typealias JsonDictionary = Dictionary<String, AnyObject>

class NhkApi {
  let baseUrl = "http://api.nhk.or.jp"
  let key = ""
  let version = 1
  
  internal enum Area : String{
    static func defaultValue() -> Area {
      return 東京
    }
    
    case 札幌 = "010", 函館 = "011", 旭川 = "012", 帯広 = "013", 釧路 = "014", 北見 = "015", 室蘭 = "016", 青森 = "020"
    case 盛岡 = "030", 仙台 = "040", 秋田 = "050", 山形 = "060", 福島 = "070", 水戸 = "080", 宇都宮 = "090", 前橋 = "100"
    case さいたま = "110", 千葉 = "120", 東京 = "130", 横浜 = "140", 新潟 = "150", 富山 = "160", 金沢 = "170", 福井 = "180"
    case 甲府 = "190", 長野 = "200", 岐阜 = "210", 静岡 = "220", 名古屋 = "230", 津 = "240", 大津 = "250", 京都 = "260"
    case 大阪 = "270", 神戸 = "280", 奈良 = "290", 和歌山 = "300", 鳥取 = "310", 松江 = "320", 岡山 = "330", 広島 = "340"
    case 山口 = "350", 徳島 = "360", 高松 = "370", 松山 = "380", 高知 = "390", 福岡 = "400", 北九州 = "401", 佐賀 = "410"
    case 長崎 = "420", 熊本 = "430", 大分 = "440", 宮崎 = "450", 鹿児島 = "460", 沖縄 = "470"
    
    static var all : [Area] {
      return [
        札幌, 函館, 旭川, 帯広, 釧路, 北見, 室蘭, 青森,
        盛岡, 仙台, 秋田, 山形, 福島, 水戸, 宇都宮, 前橋,
        さいたま, 千葉, 東京, 横浜, 新潟, 富山, 金沢, 福井,
        甲府, 長野, 岐阜, 静岡, 名古屋, 津, 大津, 京都,
        大阪, 神戸, 奈良, 和歌山, 鳥取, 松江, 岡山, 広島,
        山口, 徳島, 高松, 松山, 高知, 福岡, 北九州, 佐賀,
        長崎, 熊本, 大分, 宮崎, 鹿児島, 沖縄,
      ]
    }

    var text:String {
      switch self {
        case .札幌: return "札幌"
        case .函館: return "函館"
        case .旭川: return "旭川"
        case .帯広: return "帯広"
        case .釧路: return "釧路"
        case .北見: return "北見"
        case .室蘭: return "室蘭"
        case .青森: return "青森"
        case .盛岡: return "盛岡"
        case .仙台: return "仙台"
        case .秋田: return "秋田"
        case .山形: return "山形"
        case .福島: return "福島"
        case .水戸: return "水戸"
        case .宇都宮: return "宇都宮"
        case .前橋: return "前橋"
        case .さいたま: return "さいたま"
        case .千葉: return "千葉"
        case .東京: return "東京"
        case .横浜: return "横浜"
        case .新潟: return "新潟"
        case .富山: return "富山"
        case .金沢: return "金沢"
        case .福井: return "福井"
        case .甲府: return "甲府"
        case .長野: return "長野"
        case .岐阜: return "岐阜"
        case .静岡: return "静岡"
        case .名古屋: return "名古屋"
        case .津: return "津"
        case .大津: return "大津"
        case .京都: return "京都"
        case .大阪: return "大阪"
        case .神戸: return "神戸"
        case .奈良: return "奈良"
        case .和歌山: return "和歌山" 
        case .鳥取: return "鳥取"
        case .松江: return "松江"
        case .岡山: return "岡山"
        case .広島: return "広島"
        case .山口: return "山口"
        case .徳島: return "徳島"
        case .高松: return "高松"
        case .松山: return "松山"
        case .高知: return "高知"
        case .福岡: return "福岡"
        case .北九州: return "北九州"
        case .佐賀: return "佐賀"
        case .長崎: return "長崎"
        case .熊本: return "熊本"
        case .大分: return "大分"
        case .宮崎: return "宮崎"
        case .鹿児島: return "鹿児島"
        case .沖縄: return "沖縄"
      }
    }
  }
  
  internal enum Service : String{
    static func defaultValue() -> Service {
      return NHK総合1
    }
    case NHK総合1 = "g1"
    case NHK総合2 = "g2"
    case NHKEテレ1 = "e1"
    case NHKEテレ2 = "e2"
    case NHKEテレ3 = "e3"
    case NHKワンセグ2 = "e4"
    case NHKBS1 = "s1"
    case NHKBS1（102ch） = "s2"
    case NHKBSプレミアム = "s3"
    case NHKBSプレミアム（104ch） = "s4"
    case NHKラジオ第1 = "r1"
    case NHKラジオ第2 = "r2"
    case NHKFM = "r3"
    case NHKネットラジオ第1 = "n1"
    case NHKネットラジオ第2 = "n2"
    case NHKネットラジオFM = "n3"
    case テレビ全て = "tv"
    case ラジオ全て = "radio"
    case ネットラジオ全て = "netradio"
    
    static var all:[Service] {
      return [
        .NHK総合1,
        .NHK総合2,
        .NHKEテレ1,
        .NHKEテレ2,
        .NHKEテレ3,
        .NHKワンセグ2,
        .NHKBS1,
        .NHKBS1（102ch）,
        .NHKBSプレミアム,
        .NHKBSプレミアム（104ch）,
        .NHKラジオ第1,
        .NHKラジオ第2,
        .NHKFM,
        .NHKネットラジオ第1,
        .NHKネットラジオ第2,
        .NHKネットラジオFM,
        .テレビ全て,
        .ラジオ全て,
        .ネットラジオ全て,
      ]
    }
    
    var text:String {
      switch self {
      case .NHK総合1: return "NHK総合1"
      case .NHK総合2: return "NHK総合2"
      case .NHKEテレ1: return "NHK Eテレ1"
      case .NHKEテレ2: return "NHK Eテレ2"
      case .NHKEテレ3: return "NHK Eテレ3"
      case .NHKワンセグ2: return "NHKワンセグ2"
      case .NHKBS1: return "NHK BS1"
      case .NHKBS1（102ch）: return "NHK BS1（102ch）"
      case .NHKBSプレミアム: return "NHK BSプレミアム"
      case .NHKBSプレミアム（104ch）: return "NHK BSプレミアム（104ch）"
      case .NHKラジオ第1: return "NHKラジオ第1"
      case .NHKラジオ第2: return "NHKラジオ第2"
      case .NHKFM: return "NHK FM"
      case .NHKネットラジオ第1: return "NHKネットラジオ第1"
      case .NHKネットラジオ第2: return "NHKネットラジオ第2"
      case .NHKネットラジオFM: return "NHKネットラジオFM"
      case .テレビ全て: return "テレビ全て"
      case .ラジオ全て: return "ラジオ全て"
      case .ネットラジオ全て: return "ネットラジオ全て"
      }
    }
  }
  
  /// http://www.arib.or.jp/english/html/overview/doc/2-STD-B10v5_1.pdf
  internal enum GenreType : UInt{
    static func defaultValue() -> GenreType {
      return GenreType.定時・総合
    }
    
    case 定時・総合 = 0x0000
    case 天気 = 0x0001
    case 特集・ドキュメント = 0x0002
    case 政治・国会 = 0x0003
    case 経済・市況 = 0x0004
    case 海外・国際 = 0x0005
    case 解説 = 0x0006
    case 討論・会談 = 0x0007
    case 報道特番 = 0x0008
    case ローカル・地域 = 0x0009
    case 交通 = 0x000A
    case ニュースその他 = 0x000F
    static func news() -> [GenreType] {
      return [定時・総合, 天気, 特集・ドキュメント, 政治・国会, 経済・市況, 海外・国際, 解説, 討論・会談, 報道特番, ローカル・地域, 交通, ニュースその他]
    }
    
    case スポーツニュース = 0x0100
    case 野球 = 0x0101
    case サッカー = 0x0102
    case ゴルフ = 0x0103
    case その他の球技 = 0x0104
    case 相撲・格闘技 = 0x0105
    case オリンピック・国際大会 = 0x0106
    case マラソン・陸上・水泳 = 0x0107
    case モータースポーツ = 0x0108
    case マリン・ウィンタースポーツ = 0x0109
    case 競馬・公営競技 = 0x010A
    case スポーツその他 = 0x010F
    static func sport() -> [GenreType] {
      return [スポーツニュース, 野球, サッカー, ゴルフ, その他の球技, 相撲・格闘技, オリンピック・国際大会, マラソン・陸上・水泳, モータースポーツ, マリン・ウィンタースポーツ, 競馬・公営競技, スポーツその他,]
    }
    
    case 芸能・ワイドショー = 0x0200
    case ファッション = 0x0201
    case 暮らし・住まい = 0x0202
    case 健康・医療 = 0x0203
    case ショッピング・通販 = 0x0204
    case グルメ・料理 = 0x0205
    case イベント = 0x0206
    case 番組紹介・お知らせ = 0x0207
    case 情報／ワイドショーその他 = 0x020F
    static func entertainment() -> [GenreType] {
      return [芸能・ワイドショー, ファッション, 暮らし・住まい, 健康・医療, ショッピング・通販, グルメ・料理, イベント, 番組紹介・お知らせ, 情報／ワイドショーその他,]
    }
    
    case 国内ドラマ = 0x0300
    case 海外ドラマ = 0x0301
    case 時代劇 = 0x0303
    case ドラマその他 = 0x030F
    static func drama() -> [GenreType] {
      return [国内ドラマ, 海外ドラマ, 時代劇, ドラマその他,]
    }
    
    case 国内ロック・ポップス = 0x0400
    case 海外ロック・ポップス = 0x0401
    case クラシック・オペラ = 0x0402
    case ジャズ・フュージョン = 0x0403
    case 歌謡曲・演歌 = 0x0404
    case ライブ・コンサート = 0x0405
    case ランキング・リクエスト = 0x0406
    case カラオケ・のど自慢 = 0x0407
    case 民謡・邦楽 = 0x0408
    case 童謡・キッズ = 0x0409
    case 民族音楽・ワールドミュージック = 0x040A
    case 音楽その他 = 0x040F
    static func music() -> [GenreType] {
      return [国内ロック・ポップス, 海外ロック・ポップス, クラシック・オペラ, ジャズ・フュージョン, 歌謡曲・演歌, ライブ・コンサート, ランキング・リクエスト, カラオケ・のど自慢, 民謡・邦楽, 童謡・キッズ, 民族音楽・ワールドミュージック, 音楽その他,]
    }
    
    case クイズ = 0x0500
    case ゲーム = 0x0501
    case トークバラエティ = 0x0502
    case お笑い・コメディ = 0x0503
    case 音楽バラエティ = 0x0504
    case 旅バラエティ = 0x0505
    case 料理バラエティ = 0x0506
    case バラエティその他 = 0x050F
    static func variety() -> [GenreType] {
      return [クイズ, ゲーム, トークバラエティ, お笑い・コメディ, 音楽バラエティ, 旅バラエティ, 料理バラエティ, バラエティその他,]
    }
    
    case 洋画 = 0x0600
    case 邦画 = 0x0601
    case アニメ映画 = 0x0602
    case 映画その他 = 0x060F
    static func movie() -> [GenreType] {
      return [洋画, 邦画, アニメ映画, 映画その他,]
    }
    
    case 国内アニメ = 0x0700
    case 海外アニメ = 0x0701
    case 特撮 = 0x0702
    case アニメその他 = 0x070F
    static func anime() -> [GenreType] {
      return [国内アニメ, 海外アニメ, 特撮, アニメその他,]
    }
    
    case 社会・時事 = 0x0800
    case 歴史・紀行 = 0x0801
    case 自然・動物・環境 = 0x0802
    case 宇宙・科学・医学 = 0x0803
    case カルチャー・伝統文化 = 0x0804
    case 文学・文芸 = 0x0805
    case スポーツドキュメンタリー = 0x0806
    case ドキュメンタリー全般 = 0x0807
    case インタビュー・討論 = 0x0808
    case ドキュメンタリーその他 = 0x080F
    static func documentary() -> [GenreType] {
      return [社会・時事, 歴史・紀行, 自然・動物・環境, 宇宙・科学・医学, カルチャー・伝統文化, 文学・文芸, スポーツドキュメンタリー, ドキュメンタリー全般, インタビュー・討論, ドキュメンタリーその他,]
    }
    
    case 現代劇・新劇 = 0x0900
    case ミュージカル = 0x0901
    case ダンス・バレエ = 0x0902
    case 落語・演芸 = 0x0903
    case 歌舞伎・古典 = 0x0904
    case 劇場公演その他 = 0x090F
    static func musical() -> [GenreType] {
      return [現代劇・新劇, ミュージカル, ダンス・バレエ, 落語・演芸, 歌舞伎・古典, 劇場公演その他,]
    }
    
    case 旅・釣り・アウトドア = 0x0A00
    case 園芸・ペット・手芸 = 0x0A01
    case 音楽・美術・工芸 = 0x0A02
    case 囲碁・将棋 = 0x0A03
    case 麻雀・パチンコ = 0x0A04
    case 車・オートバイ = 0x0A05
    case コンピュータ・ＴＶゲーム = 0x0A06
    case 会話・語学 = 0x0A07
    case 幼児・小学生 = 0x0A08
    case 中学生・高校生 = 0x0A09
    case 大学生・受験 = 0x0A0A
    case 生涯教育・資格 = 0x0A0B
    case 教育問題 = 0x0A0C
    case 趣味・教育その他 = 0x0A0F
    static func hobby() -> [GenreType]{
      return [旅・釣り・アウトドア, 園芸・ペット・手芸, 音楽・美術・工芸, 囲碁・将棋, 麻雀・パチンコ, 車・オートバイ, コンピュータ・ＴＶゲーム, 会話・語学, 幼児・小学生, 中学生・高校生, 大学生・受験, 生涯教育・資格, 教育問題, 趣味・教育その他,]
    }
    
    case 高齢者 = 0x0B00
    case 障害者 = 0x0B01
    case 社会福祉 = 0x0B02
    case ボランティア = 0x0B03
    case 手話 = 0x0B04
    case 文字（字幕） = 0x0B05
    case 音声解説 = 0x0B06
    case 福祉その他 = 0x0B0F
    static func humanService() -> [GenreType]{
      return [高齢者, 障害者, 社会福祉, ボランティア, 手話, 文字（字幕）, 音声解説, 福祉その他,]
    }
    
    var code:String {
      let code = NSString(format:"%04d", self.rawValue)
      return code
    }
  }
  
  internal enum Method {
    case List(area:Area,service:Service, date:String)
    case Genre(area:Area, service:Service, genre:GenreType, date:String)
    case Info(area:Area, service:Service, id:Int)
    case NowOnAir(area:Area, service:Service)
    
    func url(baseUrl:String) -> String {
      switch self {
      case let .List(area, service, date): return "\(baseUrl)/list/\(area.rawValue)/\(service.rawValue)/\(date).json"
      case let .Genre(area, service, genre, date): return "\(baseUrl)/genre/\(area.rawValue)/\(service.rawValue)/\(genre.rawValue)/\(date).json"
      case let Info(area, service, id): return "\(baseUrl)/info/\(area.rawValue)/\(service.rawValue)/\(id).json"
      case let NowOnAir(area, service): return "\(baseUrl)/now/\(area.rawValue)/\(service.rawValue).json"
      }
    }
    
    var name:String {
      switch self {
      case List: return "プログラム一覧"
      case Genre: return "ジャンル検索"
      case Info: return "番組情報"
      case NowOnAir: return "放送中番組"
      }
    }
  }
  
  func makeUrl(method:Method) -> String {
    var result : String = ""
    
    let baseUrl = "\(self.baseUrl)/v\(self.version)/pg"
    result = method.url(baseUrl) + "?key=\(self.key)";
    
    return result
  }
  
  func request(method:Method, handler:(json:JsonDictionary) -> Void) -> String {
    let url = self.makeUrl(method)
    Alamofire.request(.GET, url).responseJSON(
      {(_, _, json, error) in
        var jsonDictionary:JsonDictionary = JsonDictionary()
        
        if let jsonArray = json as? [JsonDictionary] {
          for var i = 0; i < jsonArray.count; i++ {
            let dict = jsonArray[i]
            jsonDictionary[String(i)] = dict
          }
        }
        else if let jsonArray = json as? JsonDictionary {
          jsonDictionary = jsonArray
        }

        handler(json: jsonDictionary)
      }
    )
    
    return url
  }
  
  init(apiKey:String) {
    self.key = apiKey
  }
  
  class var availableDate:(String, String) {
    var date = NSDate()
    let formatter = NSDateFormatter()
    formatter.locale = NSLocale(localeIdentifier: "ja_JP")
    formatter.dateFormat = "yyyy-MM-dd"
    let today = formatter.stringFromDate(date)
    date = date.dateByAddingTimeInterval(NSTimeInterval(60*60*24))
    let tommorow = formatter.stringFromDate(date)
    return (today, tommorow)
  }

}
