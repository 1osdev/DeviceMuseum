//
//  CreateAccountVC.swift
//  DeviceMuseum
//
//  Created by Дмитрий Смирнов on 23.04.22.
//

import UIKit

final class CreateAccountVC: UIViewController {

    @IBOutlet private weak var emailTF: UITextField!
    @IBOutlet private weak var emailErrorLbl: UILabel!

    @IBOutlet private weak var nameTF: UITextField!

    @IBOutlet private weak var passTF: UITextField!
    @IBOutlet private weak var passErrorLbl: UILabel!

    @IBOutlet private var verifPassView: [UIView]!

    @IBOutlet private weak var confPassTF: UITextField!
    @IBOutlet private weak var confPassErrorLbl: UILabel!
    
    @IBOutlet private weak var signUpBtn: UIButton!

    @IBOutlet private weak var scrollView: UIScrollView!

    private var isValidEmail = false
    private var isConfPass = false
    private var passwordStrength: PasswordStrength = .veryWeak

    override func viewDidLoad() {
        super.viewDidLoad()
        startKeyboardObserver()
        hideKeyboardWhenTappedAround()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let email = emailTF.text,
            let pass = passTF.text,
            let destVC = segue.destination as? CodeVerifVC else { return }

        destVC.email = email
        destVC.name = nameTF.text
        destVC.pass = pass
    }

    @IBAction private func signInButtonTouch() {
        navigationController?.popToRootViewController(animated: true)
    }

    @IBAction private func emailTFChanged(_ sender: UITextField) {
        guard let email = sender.text else { return }
        isValidEmail = VerificationService.isValidEmail(email: email)
        emailErrorLbl.isHidden = isValidEmail
        updateBtnState()
    }

    @IBAction private func passTFChanged(_ sender: UITextField) {

        // check pass by strength
        guard let pass1 = sender.text else { return }
        passwordStrength = VerificationService.isValidPassword(pass: pass1)
        passErrorLbl.isHidden = !(passwordStrength == .veryWeak)
        verifPassView.enumerated().forEach { (index, view) in
            if (index <= (passwordStrength.rawValue - 1)) {
                view.alpha = 1
            } else {
                view.alpha = 0.1
            }
        }

        // check confPass
        guard let pass2 = confPassTF.text else { return }
        updatePassErrorLbl(pass1: pass1, pass2: pass2)

        // updateBtn
        updateBtnState()
    }

    @IBAction private func confPassTFChanged(_ sender: UITextField) {
        guard let pass1 = passTF.text,
            let pass2 = sender.text else { return }
        updatePassErrorLbl(pass1: pass1, pass2: pass2)
        updateBtnState()
    }

    @IBAction private func signUpTouch(_ sender: UIButton) {
        performSegue(withIdentifier: "showCodeVerVC", sender: nil)
    }

    private func updatePassErrorLbl(pass1: String, pass2: String) {
        isConfPass = VerificationService.isPassCofirm(pass1: pass1, pass2: pass2)
        confPassErrorLbl.isHidden = isConfPass
    }

    private func updateBtnState() {
        signUpBtn.isEnabled = isValidEmail &&
            isConfPass && (passwordStrength != .veryWeak)
    }
    
    private func startKeyboardObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func keyboardWillHide() {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
}

