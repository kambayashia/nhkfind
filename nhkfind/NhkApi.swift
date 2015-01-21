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

struct NhkLogo {
  let url:String?
  let width:Int?
  let height:Int?
}

struct NhkProgram {
  struct Area {
    let id:String
    let name:String
  }
  
  struct Service {
    let id:String
    let name:String
    let logo_s:NhkLogo
    let logo_m:NhkLogo
    let logo_l:NhkLogo
  }
  let id:String
  let eventId:String 
  let startTime:NSDate
  let endTime:NSDate
  let title:String
  let subTitle:String
  let area:Area
  let service:Service
  let genres:[String]
}

struct NhkProgramDetail {
  struct Link {
    let url:String?
    let id:String?
    let title:String?
  }

  struct Extras {
    let ondemandProgram:Link?
    let ondemandEposode:Link?
  }
  
  let program:NhkProgram
  let logo:NhkLogo
  let programUrl:String?
  let episodeUrl:String?
  let hashTags:[String]
  let extras:Extras?
}

struct NhkNowOnAir {
  let previous:NhkProgram?
  let present:NhkProgram
  let following:NhkProgram?
}

class NhkApi {
  let baseUrl = "http://api.nhk.or.jp"
  let key = ""
  let version = 1
  
  enum Area : String{
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

    static func index(value:Area) -> Int {
      var result:Int = 0
      let allCount = all.count
      
      for var i = 0; i < allCount; i++ {
        let item = all[i]
        if item == value {
          result = i
          break
        }
      }
      return result
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
  
  enum Service : String{
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
    
    static func index(value:Service) -> Int {
      var result:Int = 0
      let allCount = all.count
      
      for var i = 0; i < allCount; i++ {
        let item = all[i]
        if item == value {
          result = i
          break
        }
      }
      return result
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
  enum GenreType : String{
    static func defaultValue() -> GenreType {
      return GenreType.定時・総合
    }
    
    case 定時・総合 = "0000"
    case 天気 = "0001"
    case 特集・ドキュメント = "0002"
    case 政治・国会 = "0003"
    case 経済・市況 = "0004"
    case 海外・国際 = "0005"
    case 解説 = "0006"
    case 討論・会談 = "0007"
    case 報道特番 = "0008"
    case ローカル・地域 = "0009"
    case 交通 = "0010"
    case ニュースその他 = "0015"
    static var news:[GenreType] {
      return [定時・総合, 天気, 特集・ドキュメント, 政治・国会, 経済・市況, 海外・国際, 解説, 討論・会談, 報道特番, ローカル・地域, 交通, ニュースその他]
    }
    
    case スポーツニュース = "0100"
    case 野球 = "0101"
    case サッカー = "0102"
    case ゴルフ = "0103"
    case その他の球技 = "0104"
    case 相撲・格闘技 = "0105"
    case オリンピック・国際大会 = "0106"
    case マラソン・陸上・水泳 = "0107"
    case モータースポーツ = "0108"
    case マリン・ウィンタースポーツ = "0109"
    case 競馬・公営競技 = "0110"
    case スポーツその他 = "0115"
    static var sport:[GenreType] {
      return [スポーツニュース, 野球, サッカー, ゴルフ, その他の球技, 相撲・格闘技, オリンピック・国際大会, マラソン・陸上・水泳, モータースポーツ, マリン・ウィンタースポーツ, 競馬・公営競技, スポーツその他,]
    }
    
    case 芸能・ワイドショー = "0200"
    case ファッション = "0201"
    case 暮らし・住まい = "0202"
    case 健康・医療 = "0203"
    case ショッピング・通販 = "0204"
    case グルメ・料理 = "0205"
    case イベント = "0206"
    case 番組紹介・お知らせ = "0207"
    case 情報／ワイドショーその他 = "0215"
    static var entertainment:[GenreType] {
      return [芸能・ワイドショー, ファッション, 暮らし・住まい, 健康・医療, ショッピング・通販, グルメ・料理, イベント, 番組紹介・お知らせ, 情報／ワイドショーその他,]
    }
    
    case 国内ドラマ = "0300"
    case 海外ドラマ = "0301"
    case 時代劇 = "0303"
    case ドラマその他 = "0315"
    static var drama:[GenreType] {
      return [国内ドラマ, 海外ドラマ, 時代劇, ドラマその他,]
    }
    
    case 国内ロック・ポップス = "0400"
    case 海外ロック・ポップス = "0401"
    case クラシック・オペラ = "0402"
    case ジャズ・フュージョン = "0403"
    case 歌謡曲・演歌 = "0404"
    case ライブ・コンサート = "0405"
    case ランキング・リクエスト = "0406"
    case カラオケ・のど自慢 = "0407"
    case 民謡・邦楽 = "0408"
    case 童謡・キッズ = "0409"
    case 民族音楽・ワールドミュージック = "0410"
    case 音楽その他 = "0415"
    static var music:[GenreType] {
      return [国内ロック・ポップス, 海外ロック・ポップス, クラシック・オペラ, ジャズ・フュージョン, 歌謡曲・演歌, ライブ・コンサート, ランキング・リクエスト, カラオケ・のど自慢, 民謡・邦楽, 童謡・キッズ, 民族音楽・ワールドミュージック, 音楽その他,]
    }
    
    case クイズ = "0500"
    case ゲーム = "0501"
    case トークバラエティ = "0502"
    case お笑い・コメディ = "0503"
    case 音楽バラエティ = "0504"
    case 旅バラエティ = "0505"
    case 料理バラエティ = "0506"
    case バラエティその他 = "0515"
    static var variety:[GenreType] {
      return [クイズ, ゲーム, トークバラエティ, お笑い・コメディ, 音楽バラエティ, 旅バラエティ, 料理バラエティ, バラエティその他,]
    }
    
    case 洋画 = "0600"
    case 邦画 = "0601"
    case アニメ映画 = "0602"
    case 映画その他 = "0615"
    static var movie:[GenreType] {
      return [洋画, 邦画, アニメ映画, 映画その他,]
    }
    
    case 国内アニメ = "0700"
    case 海外アニメ = "0701"
    case 特撮 = "0702"
    case アニメその他 = "0715"
    static var anime:[GenreType] {
      return [国内アニメ, 海外アニメ, 特撮, アニメその他,]
    }
    
    case 社会・時事 = "0800"
    case 歴史・紀行 = "0801"
    case 自然・動物・環境 = "0802"
    case 宇宙・科学・医学 = "0803"
    case カルチャー・伝統文化 = "0804"
    case 文学・文芸 = "0805"
    case スポーツドキュメンタリー = "0806"
    case ドキュメンタリー全般 = "0807"
    case インタビュー・討論 = "0808"
    case ドキュメンタリーその他 = "0815"
    static var documentary:[GenreType] {
      return [社会・時事, 歴史・紀行, 自然・動物・環境, 宇宙・科学・医学, カルチャー・伝統文化, 文学・文芸, スポーツドキュメンタリー, ドキュメンタリー全般, インタビュー・討論, ドキュメンタリーその他,]
    }
    
    case 現代劇・新劇 = "0900"
    case ミュージカル = "0901"
    case ダンス・バレエ = "0902"
    case 落語・演芸 = "0903"
    case 歌舞伎・古典 = "0904"
    case 劇場公演その他 = "0915"
    static var musical:[GenreType] {
      return [現代劇・新劇, ミュージカル, ダンス・バレエ, 落語・演芸, 歌舞伎・古典, 劇場公演その他,]
    }
    
    case 旅・釣り・アウトドア = "1000"
    case 園芸・ペット・手芸 = "1001"
    case 音楽・美術・工芸 = "1002"
    case 囲碁・将棋 = "1003"
    case 麻雀・パチンコ = "1004"
    case 車・オートバイ = "1005"
    case コンピュータ・ＴＶゲーム = "1006"
    case 会話・語学 = "1007"
    case 幼児・小学生 = "1008"
    case 中学生・高校生 = "1009"
    case 大学生・受験 = "1010"
    case 生涯教育・資格 = "1011"
    case 教育問題 = "1012"
    case 趣味・教育その他 = "1015"
    static var hobby:[GenreType] {
      return [旅・釣り・アウトドア, 園芸・ペット・手芸, 音楽・美術・工芸, 囲碁・将棋, 麻雀・パチンコ, 車・オートバイ, コンピュータ・ＴＶゲーム, 会話・語学, 幼児・小学生, 中学生・高校生, 大学生・受験, 生涯教育・資格, 教育問題, 趣味・教育その他,]
    }
    
    case 高齢者 = "1100"
    case 障害者 = "1101"
    case 社会福祉 = "1102"
    case ボランティア = "113"
    case 手話 = "1104"
    case 文字（字幕） = "1105"
    case 音声解説 = "1106"
    case 福祉その他 = "1115"
    static var humanService:[GenreType]{
      return [高齢者, 障害者, 社会福祉, ボランティア, 手話, 文字（字幕）, 音声解説, 福祉その他,]
    }
    
    static var all:[GenreType] {
      var all:[GenreType] = []
       all  = all + news
       all  = all + sport
       all  = all + entertainment
       all  = all + drama
       all  = all + music
       all  = all + variety
       all  = all + movie
       all  = all + anime
       all  = all + musical
       all  = all + hobby
       all  = all + humanService
      
      return all
    }
    static func index(value:GenreType) -> Int {
      var result:Int = 0
      let allCount = all.count
      
      for var i = 0; i < allCount; i++ {
        let item = all[i]
        if item == value {
          result = i
          break
        }
      }
      return result
    }

    var code:String {
      return self.rawValue
    }
    
    var text:String {
      switch self {
      case 定時・総合: return "定時・総合"
      case 天気: return "天気"
      case 特集・ドキュメント: return "特集・ドキュメント"
      case 政治・国会: return "政治・国会"
      case 経済・市況: return "経済・市況"
      case 海外・国際: return "海外・国際"
      case 解説: return "解説"
      case 討論・会談: return "討論・会談"
      case 報道特番: return "報道特番"
      case ローカル・地域: return "ローカル・地域"
      case 交通: return "交通"
      case ニュースその他: return "ニュースその他"
      
      case スポーツニュース: return "スポーツニュース"
      case 野球: return "野球"
      case サッカー: return "サッカー"
      case ゴルフ: return "ゴルフ"
      case その他の球技: return "その他の球技"
      case 相撲・格闘技: return "相撲・格闘技"
      case オリンピック・国際大会: return "オリンピック・国際大会"
      case マラソン・陸上・水泳: return "マラソン・陸上・水泳"
      case モータースポーツ: return "モータースポーツ"
      case マリン・ウィンタースポーツ: return "マリン・ウィンタースポーツ"
      case 競馬・公営競技: return "競馬・公営競技"
      case スポーツその他: return "スポーツその他"
      
      case 芸能・ワイドショー: return "芸能・ワイドショー"
      case ファッション: return "ファッション"
      case 暮らし・住まい: return "暮らし・住まい"
      case 健康・医療: return "健康・医療"
      case ショッピング・通販: return "ショッピング・通販"
      case グルメ・料理: return "グルメ・料理"
      case イベント: return "イベント"
      case 番組紹介・お知らせ: return "番組紹介・お知らせ"
      case 情報／ワイドショーその他: return "情報／ワイドショーその他"
      
      case 国内ドラマ: return "国内ドラマ"
      case 海外ドラマ: return "海外ドラマ"
      case 時代劇: return "時代劇"
      case ドラマその他: return "ドラマその他"
      
      case 国内ロック・ポップス: return "国内ロック・ポップス"
      case 海外ロック・ポップス: return "海外ロック・ポップス"
      case クラシック・オペラ: return "クラシック・オペラ"
      case ジャズ・フュージョン: return "ジャズ・フュージョン"
      case 歌謡曲・演歌: return "歌謡曲・演歌"
      case ライブ・コンサート: return "ライブ・コンサート"
      case ランキング・リクエスト: return "ランキング・リクエスト"
      case カラオケ・のど自慢: return "カラオケ・のど自慢"
      case 民謡・邦楽: return "民謡・邦楽"
      case 童謡・キッズ: return "童謡・キッズ"
      case 民族音楽・ワールドミュージック: return "民族音楽・ワールドミュージック"
      case 音楽その他: return "音楽その他"
      
      case クイズ: return "クイズ"
      case ゲーム: return "ゲーム"
      case トークバラエティ: return "トークバラエティ"
      case お笑い・コメディ: return "お笑い・コメディ"
      case 音楽バラエティ: return "音楽バラエティ"
      case 旅バラエティ: return "旅バラエティ"
      case 料理バラエティ: return "料理バラエティ"
      case バラエティその他: return "バラエティその他"
      
      case 洋画: return "洋画"
      case 邦画: return "邦画"
      case アニメ映画: return "アニメ映画"
      case 映画その他: return "映画その他"
      
      case 国内アニメ: return "国内アニメ"
      case 海外アニメ: return "海外アニメ"
      case 特撮: return "特撮"
      case アニメその他: return "アニメその他"
      
      case 社会・時事: return "社会・時事"
      case 歴史・紀行: return "歴史・紀行"
      case 自然・動物・環境: return "自然・動物・環境"
      case 宇宙・科学・医学: return "宇宙・科学・医学"
      case カルチャー・伝統文化: return "カルチャー・伝統文化"
      case 文学・文芸: return "文学・文芸"
      case スポーツドキュメンタリー: return "スポーツドキュメンタリー"
      case ドキュメンタリー全般: return "ドキュメンタリー全般"
      case インタビュー・討論: return "インタビュー・討論"
      case ドキュメンタリーその他: return "ドキュメンタリーその他"
      
      case 現代劇・新劇: return "現代劇・新劇"
      case ミュージカル: return "ミュージカル"
      case ダンス・バレエ: return "ダンス・バレエ"
      case 落語・演芸: return "落語・演芸"
      case 歌舞伎・古典: return "歌舞伎・古典"
      case 劇場公演その他: return "劇場公演その他"
      
      case 旅・釣り・アウトドア: return "旅・釣り・アウトドア"
      case 園芸・ペット・手芸: return "園芸・ペット・手芸"
      case 音楽・美術・工芸: return "音楽・美術・工芸"
      case 囲碁・将棋: return "囲碁・将棋"
      case 麻雀・パチンコ: return "麻雀・パチンコ"
      case 車・オートバイ: return "車・オートバイ"
      case コンピュータ・ＴＶゲーム: return "コンピュータ・ＴＶゲーム"
      case 会話・語学: return "会話・語学"
      case 幼児・小学生: return "幼児・小学生"
      case 中学生・高校生: return "中学生・高校生"
      case 大学生・受験: return "大学生・受験"
      case 生涯教育・資格: return "生涯教育・資格"
      case 教育問題: return "教育問題"
      case 趣味・教育その他: return "趣味・教育その他"
      
      case 高齢者: return "高齢者"
      case 障害者: return "障害者"
      case 社会福祉: return "社会福祉"
      case ボランティア: return "ボランティア"
      case 手話: return "手話"
      case 文字（字幕）: return "文字（字幕）"
      case 音声解説: return "音声解説"
      case 福祉その他: return "福祉その他"
      }
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
      case let .Genre(area, service, genre, date): return "\(baseUrl)/genre/\(area.rawValue)/\(service.rawValue)/\(genre.code)/\(date).json"
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
  
  func makeUrl(method:Method, withoutKey:Bool) -> String {
    var result : String = ""
    
    let baseUrl = "\(self.baseUrl)/v\(self.version)/pg"
    if !withoutKey {
      result = method.url(baseUrl) + "?key=\(self.key)";
    }
    else {
      result = method.url(baseUrl) + "?key=YOUR KEY";
    }
    
    return result
  }
  
  func request(method:Method, success:(json:JsonDictionary) -> Void, failure:() -> Void) -> String {
    let url = self.makeUrl(method, withoutKey: false)
    Alamofire.request(.GET, url).responseJSON(
      {(_, _, json, error) in
        var jsonDictionary:JsonDictionary = JsonDictionary()
        
        if let jsonArray = json as? JsonDictionary {
          success(json: jsonArray)
        }
        else {
          failure()
        }
      }
    )
    
    println(url)
    return url
  }
  
  func makeProgramFromJson(json:JsonDictionary) -> NhkProgram {
    let areaJson = json["area"] as JsonDictionary
    let serviceJson = json["service"] as JsonDictionary
    let logoSJson = serviceJson["logo_s"] as JsonDictionary
    let logoMJson = serviceJson["logo_m"] as JsonDictionary
    let logoLJson = serviceJson["logo_l"] as JsonDictionary

    var formatter = NSDateFormatter()
    
    formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
    formatter.timeZone = NSTimeZone(abbreviation: "UTC")
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    
    let logo_s = NhkLogo(url: logoSJson["url"]? as? String, width: logoSJson["width"]? as? Int, height: logoSJson["height"]? as? Int)
    let logo_m = NhkLogo(url: logoMJson["url"]? as? String, width: logoMJson["width"]? as? Int, height: logoMJson["height"]? as? Int)
    let logo_l = NhkLogo(url: logoLJson["url"]? as? String, width: logoLJson["width"]? as? Int, height: logoLJson["height"]? as? Int)
    let result = NhkProgram(
      id: json["id"]! as String,
      eventId: json["event_id"]! as String,
      startTime: formatter.dateFromString(json["start_time"]! as String)!,
      endTime: formatter.dateFromString(json["end_time"]! as String)!,
      title: json["title"]! as String,
      subTitle: json["subtitle"]! as String,
      area: NhkProgram.Area(id: areaJson["id"]! as String, name: areaJson["name"]! as String),
      service: NhkProgram.Service(
        id: serviceJson["id"]! as String,
        name: serviceJson["name"]! as String,
        logo_s: logo_s,
        logo_m: logo_m,
        logo_l: logo_l
      ),
      genres: json["genres"]! as [String]
    )
    
    return result
  }
  
  func makeProgramDetailFromJson(json:JsonDictionary) -> NhkProgramDetail {
    let logoJson = json["program_logo"] as JsonDictionary
    let program = makeProgramFromJson(json)
    let logo = NhkLogo(url: logoJson["url"]? as? String, width: logoJson["width"]? as? Int, height: logoJson["height"]? as? Int)
    let result = NhkProgramDetail(
      program: program,
      logo: logo,
      programUrl: json["program_url"]? as? String,
      episodeUrl: json["episode_url"]? as? String,
      hashTags: json["hashtags"] as [String],
      extras: nil
    )
    
    return result
  }
  
  func makeNowOnAirFromJson(json:JsonDictionary) -> NhkNowOnAir {
    let presentJson = json["present"] as JsonDictionary
    
    var previous:NhkProgram? = nil
    var following:NhkProgram? = nil
    if let programJson = json["previous"] as? JsonDictionary {
      previous = makeProgramFromJson(programJson)
    }
    if let programJson = json["following"] as? JsonDictionary {
      following = makeProgramFromJson(programJson)
    }
    
    return NhkNowOnAir(
      previous: previous,
      present: makeProgramFromJson(presentJson),
      following: following
    )
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
