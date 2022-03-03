//
//  PostsTVC.swift
//  RandomImage
//
//  Created by Владимир Данилович on 3.03.22.
//

import UIKit

class PostsTVC: UITableViewController {

    var user: User?
    var posts: [Posts] = []


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getPost()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let post = posts[indexPath.row]
        cell.textLabel?.text = post.title
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = post.body
        cell.detailTextLabel?.numberOfLines = 0
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postId = posts[indexPath.row].id
        performSegue(withIdentifier: "goComments", sender: postId)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goComments",
            let postId = sender as? Int,
            let commentsTVC = segue.destination as? CommentsTVC {
            commentsTVC.getComments(pathUrl: "\(API.postPath)/\(postId)/comments")
        } else if segue.identifier == "goAddPost",
            let addPostVC = segue.destination as? AddPostVC {
            addPostVC.user = user
        }
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            posts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    private func getPost() {

        guard let userId = user?.id else { return }
        let pathURL = "\(API.postPath)?userId=\(userId)"
        guard let url = URL(string: pathURL) else { return }

        let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            do {
                self.posts = try JSONDecoder().decode([Posts].self, from: data)
            } catch let error {
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
}
