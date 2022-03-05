//
//  CustomPhotoCell.swift
//  RandomImage
//
//  Created by Владимир Данилович on 5.03.22.
//

import UIKit
import AlamofireImage
import Alamofire
import SwiftyJSON

class CustomPhotoCell: UICollectionViewCell {

    @IBOutlet weak var phImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var photo: JSON!

    func placeholderImage() {
        phImage.image = UIImage(named: "standartImage")
    }

    func putThumbnail() {
        if let thumbnailURL = photo["thumbnailUrl"].string {
            if let image = CacheManager.shared.imageCache.image(withIdentifier: thumbnailURL) {
                activityIndicator.stopAnimating()
                phImage.image = image
            } else {
                AF.request(thumbnailURL).responseImage { [weak self] response in
                    if case .success(let image) = response.result {
                        self?.activityIndicator.stopAnimating()
                        self?.phImage.image = image
                        CacheManager.shared.imageCache.add(image, withIdentifier: thumbnailURL)
                    }
                }
            }
        }
    }
}

