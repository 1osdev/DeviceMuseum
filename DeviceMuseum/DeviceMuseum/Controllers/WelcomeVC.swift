//
//  WelcomeVC.swift
//  DeviceMuseum
//
//  Created by Дмитрий Смирнов on 23.04.22.
//

import UIKit

class WelcomeVC: UIViewController {
    
    var email: String?
    var name: String?
    var pass: String?

    @IBAction func continueBtnTapped() {
        guard let email = email,
              let pass = pass else { return }
        UserDefaults.standard.set(name, forKey: Constants.name)
        UserDefaults.standard.set(email, forKey: Constants.email)
        UserDefaults.standard.set(pass, forKey: Constants.pass)
        navigationController?.popToRootViewController(animated: true)
    }
}
