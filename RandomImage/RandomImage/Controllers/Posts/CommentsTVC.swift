//
//  CommentsTVC.swift
//  RandomImage
//
//  Created by Владимир Данилович on 3.03.22.
//

import UIKit

class CommentsTVC: UITableViewController {

    var comments: [Comments] = []

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return comments.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let comment = comments[indexPath.row]
        cell.textLabel?.text = comment.name
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = comment.body
        cell.detailTextLabel?.numberOfLines = 0
        return cell
    }

    func getComments(pathUrl: String) {
        guard let url = URL(string: pathUrl) else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
            guard let data = data else { return }
            do {
                self?.comments = try JSONDecoder().decode([Comments].self, from: data)
            } catch let error {
                print(error)
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        task.resume()
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            comments.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
