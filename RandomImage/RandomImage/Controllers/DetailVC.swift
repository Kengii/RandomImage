//
//  DetailVC.swift
//  RandomImage
//
//  Created by Владимир Данилович on 2.03.22.
//

import UIKit

class DetailVC: UIViewController {

    var user: User?

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var webSiteLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var suiteLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var zipCodeLbl: UILabel!
    @IBOutlet weak var nameCompanyLbl: UILabel!
    @IBOutlet weak var catchPharse: UILabel!
    @IBOutlet weak var bsLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIData()
    }


    @IBAction func goPosts(_ sender: UIButton) {

    }

    private func setupUIData() {
        nameLbl.text = user?.name
        userNameLbl.text = user?.username
        emailLbl.text = user?.email
        phoneLbl.text = user?.phone
        webSiteLbl.text = user?.website
        addressLbl.text = user?.address?.street
        suiteLbl.text = user?.address?.suite
        cityLbl.text = user?.address?.city
        zipCodeLbl.text = user?.address?.zipcode
        nameCompanyLbl.text = user?.company?.name
        catchPharse.text = user?.company?.catchPhrase
        bsLbl.text = user?.company?.bs
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let postTVC = segue.destination as? PostsTVC {
            postTVC.user = user
        } else if segue.identifier == "goMap",
            let mapVC = segue.destination as? MapVC {
            mapVC.user = user
        }

    }

}


