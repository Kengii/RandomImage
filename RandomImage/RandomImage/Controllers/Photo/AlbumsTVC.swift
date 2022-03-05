//
//  AlbomsTVC.swift
//  RandomImage
//
//  Created by Владимир Данилович on 5.03.22.
//

import UIKit
import Alamofire
import SwiftyJSON

class AlbumsTVC: UITableViewController {

    var user: User?
    var albums: [JSON] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        getAlbums()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        albums.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = (albums[indexPath.row]["id"].int ?? 0).description
        cell.detailTextLabel?.text = (albums[indexPath.row]["title"].string)
        cell.textLabel?.numberOfLines = 0

        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            albums.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albums = albums[indexPath.row]
        performSegue(withIdentifier: "goPhotos", sender: albums)
    }

    func getAlbums() {
        guard let userId = user?.id else { return }

        guard let url = URL(string: "\(API.albumsPath)?userId=\(userId)") else { return }

        AF.request(url).responseJSON { [weak self] response in
            switch response.result {
            case .success(let data):
                self?.albums = JSON(data).arrayValue
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "goPhotos",
            let photosVC = segue.destination as? PhotosCVC,
            let album = sender as? JSON {
            photosVC.albums = album
        }

    }
}
