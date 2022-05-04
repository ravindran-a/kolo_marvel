//
//  APIEndpoints.swift
//  KoloMarvel
//
//  Created by Ravindran on 03/05/22.
//

import Foundation

struct APIEndPoints {
    
    static let API_BASE_URL: String = "https://gateway.marvel.com/v1/public"
    static let API_PUBLIC_KEY: String = "3d0c85a97c3960e7a7facbe7ba361dd2"
    static let API_PRIVATE_KEY: String = "292c5c5db90fd7e43ded7d460855af5a31c86f29"

    enum Characters {
        case getAllCharacters(limit: Int, offset: Int, ts: String = getRandomString(length: 3))
        case searchCharacters(name: String, limit: Int, offset: Int, ts: String = getRandomString(length: 3))
        
        var url: String {
            switch self {
            case .getAllCharacters(let limit, let offset, let ts):
                return "/characters?apikey=\(API_PUBLIC_KEY)&limit=\(limit)&offset=\(offset)&ts=\(ts)&hash=\(getMD5(ts: ts))"
            case .searchCharacters(let name, let limit, let offset, let ts):
                return "/characters?apikey=\(API_PUBLIC_KEY)&limit=\(limit)&offset=\(offset)&name=\(name)&ts=\(ts)&hash=\(getMD5(ts: ts))"
            }
        }
    }
    
    enum Comics {
        case getAllComics(limit: Int, offset: Int, ts: String = getRandomString(length: 3))
        case filterComics(type: String, limit: Int, offset: Int, ts: String = getRandomString(length: 3))
        
        var url: String {
            switch self {
            case .getAllComics(let limit, let offset, let ts):
                return "/comics?apikey=\(API_PUBLIC_KEY)&limit=\(limit)&offset=\(offset)&ts=\(ts)&hash=\(getMD5(ts: ts))"
            case .filterComics(let type, let limit, let offset, let ts):
                return "/comics?dateDescriptor=\(type)&apikey=\(API_PUBLIC_KEY)&limit=\(limit)&offset=\(offset)&ts=\(ts)&hash=\(getMD5(ts: ts))"
            }
        }
    }
    
    static func getMD5(ts: String) -> String {
        return (ts + API_PRIVATE_KEY + API_PUBLIC_KEY).md5()
    }
    
    static func getRandomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map { _ in letters.randomElement()! })
    }
}
