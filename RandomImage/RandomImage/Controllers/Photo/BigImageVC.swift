//
//  BigImageVC.swift
//  RandomImage
//
//  Created by Владимир Данилович on 5.03.22.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage

class BigImageVC: UIViewController {

    var photo: JSON!

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        putPhoto()
    }

    func putPhoto() {
        if let photoURL = photo["url"].string {
            if let image = CacheManager.shared.imageCache.image(withIdentifier: photoURL) {
                activityIndicator.stopAnimating()
                imageView.image = image
            } else {
                AF.request(photoURL).responseImage { [weak self] response in
                    if case .success(let image) = response.result {
                        self?.activityIndicator.stopAnimating()
                        self?.imageView.image = image
                        CacheManager.shared.imageCache.add(image, withIdentifier: photoURL)
                    }
                }
            }
        }

    }

}
