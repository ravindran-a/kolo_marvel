//
//  Comic.swift
//  KoloMarvel
//
//  Created by Ravindran on 03/05/22.
//

import Foundation

struct ComicResponse: Codable {
    let code: Int?
    let status, etag: String?
    let data: ComicData?
}

struct ComicData: Codable {
    let offset, limit, total, count: Int?
    let results: [Comic]?
}

struct Comic: Codable {
    let id: Int?
    let title, description: String?
    let thumbnail: ComicThumbnail?
}

struct ComicThumbnail: Codable {
    let path, fileExtension: String?
    enum CodingKeys: String, CodingKey {
        case fileExtension = "extension"
        case path
    }
}
