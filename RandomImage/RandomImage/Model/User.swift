//
//  User.swift
//  RandomImage
//
//  Created by Владимир Данилович on 2.03.22.
//

import Foundation

struct User: Codable {
    let id: Int?
    let name: String?
    let username: String?
    let email: String?
    let phone: String?
    let website: String?
    let address: Address?
    let company: Company?
}

struct Address: Codable {
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
    let geo: Geo?
}

struct Company: Codable {
    let name: String?
    let catchPhrase: String?
    let bs: String?
}

struct Geo: Codable {
    let lat: String?
    let lng: String?
}

struct Posts: Codable {
    let userId: Int?
    let id: Int?
    let title: String?
    let body: String?
}

struct Comments: Codable {
    let postId: Int?
    let id: Int?
    let name: String?
    let body: String?
}
