//
//  File.swift
//  RandomImage
//
//  Created by Владимир Данилович on 5.03.22.
//

import Foundation

struct Albums: Codable {

    let userId: Int?
    let id: Int?
    let title: String?
}

struct Photo: Codable {

    let albumId: Int?
    let id: Int?
    let title: String?
    let url: String?
    let thumbnailUrl: String?
}
