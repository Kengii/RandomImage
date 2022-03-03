//
//  UserTVC.swift
//  RandomImage
//
//  Created by Владимир Данилович on 2.03.22.
//

import UIKit

class UserTVC: UITableViewController {

    private var users: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomUsersTVC

        let user = users[indexPath.row]
        cell.filling(user: user)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        performSegue(withIdentifier: "goDetail", sender: user)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? DetailVC,
            let user = sender as? User {
            detailVC.user = user
        }
    }

    func fetchData() {
        guard let url = API.jsonUsersURL else { return }

        let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            do {
                self.users = try JSONDecoder().decode([User].self, from: data)
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
