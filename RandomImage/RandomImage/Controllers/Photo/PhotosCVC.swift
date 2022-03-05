//
//  PhotosCVC.swift
//  RandomImage
//
//  Created by Владимир Данилович on 5.03.22.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage

class PhotosCVC: UICollectionViewController {

    var albums: JSON!
    var photos: [JSON] = []
    var albumss: Albums?

    override func viewDidLoad() {
        super.viewDidLoad()

        putData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let layout = UICollectionViewFlowLayout()
        let sizeWh = UIScreen.main.bounds.width / 2 - 5
        layout.itemSize = CGSize(width: sizeWh, height: sizeWh)
        collectionView.collectionViewLayout = layout
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomPhotoCell

        cell.photo = photos[indexPath.row]
        cell.placeholderImage()
        cell.putThumbnail()

        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoBigImage", sender: photos[indexPath.row])
    }


    func putData() {
        if let album = albums,
            let albumId = album["id"].int,
            let url = URL(string: "https://jsonplaceholder.typicode.com/photos?albumId=\(albumId)") {

            AF.request(url).responseJSON { [weak self] response in
                switch response.result {
                case .success(let data):
                    self?.photos = JSON(data).arrayValue
                    self?.collectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let bigImageVC = segue.destination as? BigImageVC,
            let photo = sender as? JSON {
            bigImageVC.photo = photo
        }

    }

}
