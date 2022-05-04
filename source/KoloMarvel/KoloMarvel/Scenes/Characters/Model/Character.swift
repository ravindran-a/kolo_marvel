//
//  Character.swift
//  KoloMarvel
//
//  Created by Ravindran on 03/05/22.
//

import Foundation

struct CharacterResponse: Codable {
    let code: Int?
    let status, etag: String?
    let data: CharacterData?
}

struct CharacterData: Codable {
    let offset, limit, total, count: Int?
    let results: [Character]?
}

struct Character: Codable {
    let id: Int?
    let name, description: String?
    let thumbnail: CharacterThumbnail?
}

struct CharacterThumbnail: Codable {
    let path, fileExtension: String?
    enum CodingKeys: String, CodingKey {
        case fileExtension = "extension"
        case path
    }
}
