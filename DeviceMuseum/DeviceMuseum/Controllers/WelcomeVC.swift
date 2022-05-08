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
        UserDefaults.standard.set(name, forKey: ConstantsUser.name)
        UserDefaults.standard.set(email, forKey: ConstantsUser.email)
        UserDefaults.standard.set(pass, forKey: ConstantsUser.pass)
        navigationController?.popToRootViewController(animated: true)
    }
}
