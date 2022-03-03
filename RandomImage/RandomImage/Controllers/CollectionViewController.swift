//
//  CollectionViewController.swift
//  RandomImage
//
//  Created by Владимир Данилович on 27.02.22.
//

import UIKit

private let reuseIdentifier = "Cell"

enum UserAction: String, CaseIterable {
    case downloadImage = "Download Image"
    case users = "Users"
}

class CollectionViewController: UICollectionViewController {

    private let userAction = UserAction.allCases

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return userAction.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomViewCell

        cell.customLable.text = userAction[indexPath.item].rawValue

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let users = userAction[indexPath.item]
        switch users {
        case .downloadImage:
            performSegue(withIdentifier: "ShowImage", sender: self)
        case .users:
            performSegue(withIdentifier: "Users", sender: self)
        }
    }
}
