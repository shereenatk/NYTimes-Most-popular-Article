//
//  ArticleModel.swift
//  NYTimes
//
//  Created by ios on 21/03/2024.
//

import Foundation

struct ArticleModel: Codable {
    let results: [ArticleInfo]
}

struct ArticleInfo: Codable, Identifiable {
    let id: Int
    let title: String?
    let section: String?
    let subsection: String?
    let byline: String?
    let published_date: String?
    let abstract: String?
    let url: String?
    let updated: String?
    let media: [Media]?
    let adx_keywords: String?
}

struct Media: Codable {
    let mediaMetadata: [MediaMetadatum]?

    enum CodingKeys: String, CodingKey {
        case mediaMetadata = "media-metadata"
    }
}

struct MediaMetadatum: Codable {
    let url: String?
    let format: String?
    let height, width: Int?
}
