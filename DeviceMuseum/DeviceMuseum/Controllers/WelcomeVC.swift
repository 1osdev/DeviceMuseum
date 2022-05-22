//
//  WelcomeVC.swift
//  DeviceMuseum
//
//  Created by Дмитрий Смирнов on 23.04.22.
//

import UIKit
import Firebase

class WelcomeVC: UIViewController {

    var email: String?
    var name: String?
    var pass: String?

    @IBAction func continueBtnTapped() {
        guard let email = email,
            let pass = pass, email != "", pass != ""
            else { return }

        Auth.auth().createUser(withEmail: email, password: pass, completion: { [weak self] (user, error) in
            if error == nil {
                if user != nil {
                    self?.navigationController?.popToRootViewController(animated: true)
                }
            }
        })

// When using FireBase, the function is not used
//        guard let email = email,
//              let pass = pass else { return }
//        UserDefaults.standard.set(name, forKey: ConstantsUser.name)
//        UserDefaults.standard.set(email, forKey: ConstantsUser.email)
//        UserDefaults.standard.set(pass, forKey: ConstantsUser.pass)
//        navigationController?.popToRootViewController(animated: true)
    }
}
