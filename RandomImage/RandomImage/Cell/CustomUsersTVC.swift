//
//  CustomUsersTVC.swift
//  RandomImage
//
//  Created by Владимир Данилович on 2.03.22.
//

import UIKit

class CustomUsersTVC: UITableViewCell {

    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var userNameLable: UILabel!
    
    func filling(user: User) {
        nameLable.text = user.name
        userNameLable.text = user.username
    }
}
