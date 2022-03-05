//
//  CacheManager.swift
//  RandomImage
//
//  Created by Владимир Данилович on 5.03.22.
//

import Foundation
import Alamofire
import AlamofireImage

final class CacheManager {

    private init() { }

    static let shared = CacheManager()

    let imageCache = AutoPurgingImageCache(memoryCapacity: 100_000_000, preferredMemoryUsageAfterPurge: 60_000_000)
}
