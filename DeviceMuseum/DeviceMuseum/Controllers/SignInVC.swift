//
//  ViewController.swift
//  DeviceMuseum
//
//  Created by Дмитрий Смирнов on 22.04.22.
//

import UIKit
import SwiftUI
import Firebase

final class SignInVC: UIViewController {
    
    let segueIdentifier = "contentSegue"
    //let swiftUIController = UIHostingController(rootView: ContentView())
    
    @IBOutlet private var emailTF: UITextField!
    @IBOutlet private var passTF: UITextField!
    @IBOutlet private var userErrorLbl: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
            super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        loginBtn.layer.shadowRadius = 4.0
        loginBtn.layer.shadowOpacity = 0.4
        loginBtn.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        
        userErrorLbl.alpha = 0
        
        // FireBase проверяет пользователя, если уже зарегистрирован, то открывается  WelcomeView
        Auth.auth().addStateDidChangeListener({ [weak self] (auth, user) in
            if user != nil {
                self?.performSegue(withIdentifier: (self?.segueIdentifier)!, sender: nil)
            }
        })
        }
    
    // отображение error label с интервалом
    func displayWarningLabel(withText text: String) {
        userErrorLbl.text = text
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
            self?.userErrorLbl.alpha = 1
        }) { [weak self] complete in
            self?.userErrorLbl.alpha = 0
        }
    }
    
    // переход на экран ввода данных для верификации
    @IBAction func registerBtn(_ sender: UIButton) {
    }
    
    // проверка пользователя и переход на swiftUI View
    @IBAction func goToContentView() {
        guard let email = emailTF.text,
             let pass = passTF.text, email != "", pass != ""
        else {
            displayWarningLabel(withText: "Info is incorrect")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: pass, completion: { [weak self] (user, error) in
            if error != nil {
                self?.displayWarningLabel(withText: "Error occured")
                return
            }
            if user != nil {
                self?.performSegue(withIdentifier: "contentSegue", sender: nil)
                return
            }
            self?.displayWarningLabel(withText: "No such user")
        })
        }
    
    @IBSegueAction func segueContentView(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: ContentView())
    }
    
    // При использовании FireBase функция не используется
//    private func checkUser(email: String, pass: String) -> Bool {
//        let emailSaved = UserDefaults.standard.string(forKey: ConstantsUser.email)
//        let passSaved = UserDefaults.standard.string(forKey: ConstantsUser.pass)
//        let userFound = (email == emailSaved) && (pass == passSaved)
//        return userFound
//    }
}
