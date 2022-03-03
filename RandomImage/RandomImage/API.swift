//
//  API.swift
//  RandomImage
//
//  Created by Владимир Данилович on 2.03.22.
//

import Foundation

struct API {
    static let serverPath = "http://localhost:3000/"
    static let postPath = serverPath + "posts"
    static let postPathURL = URL(string: postPath)
    static let jsonUsersURL = URL(string: "https://jsonplaceholder.typicode.com/users")
}
