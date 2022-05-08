//
//  ViewController.swift
//  DeviceMuseum
//
//  Created by Дмитрий Смирнов on 22.04.22.
//

import UIKit
import SwiftUI

final class SignInVC: UIViewController {
    
    @IBOutlet private var emailTF: UITextField!
    @IBOutlet private var passTF: UITextField!
    @IBOutlet private var userErrorLbl: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    
    let swiftUIController = UIHostingController(rootView: ContentView())
    
    override func viewDidLoad() {
            super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        loginBtn.layer.shadowRadius = 4.0
        loginBtn.layer.shadowOpacity = 0.4
        loginBtn.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        }
    
//    @IBAction private func signInTapped() {
////        let contentView = ContentView()
////                let hostingController = UIHostingController(rootView: contentView)
////                if let window = self.view.window {
////                    window.rootViewController = hostingController
////                }
//        guard let email = emailTF.text,
//            let pass = passTF.text,
//            checkUser(email: email, pass: pass)
//            else {
//            userErrorLbl.isHidden = false
//            return
//        }
////        let contentView = ContentView()
////        let hostingController = UIHostingController(rootView: contentView)
////        if let window = self.view.window {
////            window.rootViewController = hostingController
////        }
//
//        //performSegue(withIdentifier: "ContentView", sender: nil)
//        //performSegue(withIdentifier: "goToMain", sender: nil)
//    }
    
    @IBAction func goToContentView() { // _ sender: Any
        guard let email = emailTF.text,
            let pass = passTF.text,
            checkUser(email: email, pass: pass)
            else {
            userErrorLbl.isHidden = false
            return
        }
        //navigationController?.pushViewController(swiftUIController, animated: true)
        }
    
    @IBSegueAction func segueToContentView(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: ContentView())
    }
    
    private func checkUser(email: String, pass: String) -> Bool {
        let emailSaved = UserDefaults.standard.string(forKey: ConstantsUser.email)
        let passSaved = UserDefaults.standard.string(forKey: ConstantsUser.pass)
        let userFound = (email == emailSaved) && (pass == passSaved)
        return userFound
    }
}

//override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            //var swiftUIView: AnyView {
////                segue.identifier { () -> _ in "ContentView"; return AnyView(ContentView())
//                guard segue.identifier == "ContentView" else { return } //AnyView(ContentView())
//                //return AnyView(ContentView())
//        guard let hostingController = segue.destination as? HostingController else { return }
//            }
//////
