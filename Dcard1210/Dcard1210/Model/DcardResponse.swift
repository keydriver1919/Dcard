//
//  DcardResponse.swift
//  Dcard1210
//
//  Created by change on 2021/12/10.
//

import Foundation

struct DcardFront: Codable {
    var id: Int
    var title: String//標題
    var school: String?
    var forumName: String//板名
    var excerpt: String//文章
    var gender: String//性別
    var updatedAt: Date//時間
    var topics: [String]//話題
    var media: [Media?]//圖片
    var likeCount:Int
    var commentCount:Int//回應數量
}
struct Media: Codable {
    var url: String
}

struct DcardDetail: Decodable {
    let content: String//文章
}
