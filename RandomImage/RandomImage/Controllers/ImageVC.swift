//
//  ViewController.swift
//  RandomImage
//
//  Created by Владимир Данилович on 27.02.22.
//

import UIKit

class ImageVC: UIViewController {

    var timer = Timer()
    var dataUrl = DataUrl()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadImage()
        activityIndicator.hidesWhenStopped = true
        
    }
    
    private func downloadImage() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            guard let imageURL = self.dataUrl.dataUrl.randomElement() else { return }
        guard let url = URL(string: imageURL) else { return }
        
        let session = URLSession.shared
        
            self.activityIndicator.startAnimating()
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                
                if let error = error {
                    let alertController = UIAlertController(title: "Mistake", message: error.localizedDescription, preferredStyle: .alert)
                    let OK = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(OK)
                    self?.present(alertController, animated: true, completion: nil)
                    timer.invalidate()
                }
                if let response = response {
                    print(response)
                }
                if let data = data, let image = UIImage(data: data) {
                    self?.imageView.image = image
                } else {
                    self?.imageView.image = UIImage(named: "photo.artframe")
                }
            }
        }
        task.resume()
        }
    }
        }

