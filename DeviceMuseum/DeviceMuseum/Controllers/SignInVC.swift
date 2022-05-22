//
//  ViewController.swift
//  DeviceMuseum
//
//  Created by Дмитрий Смирнов on 22.04.22.
//

import UIKit
import SwiftUI
import Firebase
import UIOnboarding

final class SignInVC: UIViewController {

    let segueIdentifier = "contentSegue"
    //let swiftUIController = UIHostingController(rootView: ContentView())

    @IBOutlet private var emailTF: UITextField!
    @IBOutlet private var passTF: UITextField!
    @IBOutlet private var userErrorLbl: UILabel!
    @IBOutlet weak var loginBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Onboarding func
        setUp()
        presentOnboarding()

        hideKeyboardWhenTappedAround()
        loginBtn.layer.shadowRadius = 4.0
        loginBtn.layer.shadowOpacity = 0.4
        loginBtn.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)

        userErrorLbl.alpha = 0

        // Firebase checks the user, if already registered, then opens  WelcomeView
        Auth.auth().addStateDidChangeListener({ [weak self] (auth, user) in
            if user != nil {
                self?.performSegue(withIdentifier: (self?.segueIdentifier)!, sender: nil)
            }
        })
    }

    // Onboarding View display
    @objc private func presentOnboarding() {
        let onboardingController: UIOnboardingViewController = .init(withConfiguration: .setUp())
        onboardingController.delegate = self
        navigationController?.present(onboardingController, animated: false)
    }

    // Onboarding on first load View #1?
//    private func showOnboarding() {
//        let isNeed = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
//        if !isNeed {
//            let onboarding = UINavigationController(rootViewController: SignInVC())
//            self.present(onboarding, animated: true)
//        }
//    }

    // When leaving the profile, the fields email and password become empty
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        emailTF.text = ""
//        passTF.text = ""
//    }

    // Display Error label with time interval
    func displayWarningLabel(withText text: String) {
        userErrorLbl.text = text
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
            self?.userErrorLbl.alpha = 1
        }) { [weak self] complete in
            self?.userErrorLbl.alpha = 0
        }
    }

    // Go to the data entry screen for verification
    @IBAction func registerBtn(_ sender: UIButton) {
    }

    // User verification and transition to SwiftUI View
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

    // In the storyboard, it is necessary to extend the action from segue to IBSegueAction
    @IBSegueAction func segueContentView(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: ContentView())
    }

    // When using FireBase, the function is not used
//    private func checkUser(email: String, pass: String) -> Bool {
//        let emailSaved = UserDefaults.standard.string(forKey: ConstantsUser.email)
//        let passSaved = UserDefaults.standard.string(forKey: ConstantsUser.pass)
//        let userFound = (email == emailSaved) && (pass == passSaved)
//        return userFound
//    }
}

// Onboarding extension
extension SignInVC {
    private func setUp() {
        view.backgroundColor = .systemBackground
        //navigationController?.navigationBar.tintColor = .init(named: "camou")
        navigationItem.rightBarButtonItem = .init(image: .init(systemName: "repeat"), style: .plain, target: self, action: #selector(presentOnboarding))
    }
}

extension SignInVC: UIOnboardingViewControllerDelegate {
    func didFinishOnboarding(onboardingViewController: UIOnboardingViewController) {
        onboardingViewController.modalTransitionStyle = .crossDissolve
        onboardingViewController.dismiss(animated: true, completion: nil)
        // // Onboarding on first load View #2?
//        onboardingViewController.dismiss(animated: true) {
//            UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
//        }
    }
}

#if DEBUG
    struct ViewControllerContainer: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UINavigationController {
            return .init(rootViewController: SignInVC.init())
        }
        func updateUIViewController(_ uiViewController: UINavigationController, context: Context) { }
    }

    struct ContentViewController_Previews: PreviewProvider {
        static var previews: some View {
            Group {
                ViewControllerContainer()
                    .preferredColorScheme(.light)
            }
        }
    }
#endif

