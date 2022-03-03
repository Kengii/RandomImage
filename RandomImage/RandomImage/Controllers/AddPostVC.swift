//
//  ViewController.swift
//  RandomImage
//
//  Created by Владимир Данилович on 3.03.22.
//

import UIKit

class AddPostVC: UIViewController {

    var user: User?
    
    @IBOutlet weak var postTitleTF: UITextField!
    @IBOutlet weak var postBodyTV: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func addPostAction(_ sender: UIButton) {
        if let userId = user?.id,
           let title = postTitleTF.text,
           let body = postBodyTV.text,
           let url = API.postPathURL {
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let post: [String: Any] = ["userId": userId,
                                       "title": title,
                                       "body": body]
            guard let httpBody = try? JSONSerialization.data(withJSONObject: post, options: []) else { return }
                    request.httpBody = httpBody
            URLSession.shared.dataTask(with: request) { data, _, _ in
                if let data = data {
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }.resume()
        }
    }
    
}
