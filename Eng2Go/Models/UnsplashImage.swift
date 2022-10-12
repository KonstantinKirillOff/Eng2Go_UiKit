//
//  UnsplashImage.swift
//  Eng2Go
//
//  Created by Konstantin Kirillov on 12.10.2022.
//

import Foundation

struct UnsplashResponse: Decodable{
    let results: [ImageData]
}

struct ImageData: Decodable {
    let description: String?
    let urls: [String : String]
}
