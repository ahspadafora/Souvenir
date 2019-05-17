//
//  SignUpViewController.swift
//  souvenir
//
//  Created by Amber Spadafora on 5/16/19.
//  Copyright © 2019 Amber Spadafora. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var phoneNumberAndEmailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    // TO DO: TURN INTO USER MODEL
    var username: String?
    var email: String?
    var password: String?
    var confirmedPassword: String?
    var phoneNumber: String?
    lazy var signUpViewModel: SignUpViewModel = {
        return SignUpViewModel()
    }()
    // MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViewModel()
    }
    private func initializeViewModel() {
        signUpViewModel.createdEmailAccountClosure = { [weak self] (email, password, error) in
            if error != nil {
                // TODO: display error
                print(error?.localizedDescription)
                return
            }
            if let email = email, let password = password {
                self?.email = email
                self?.password = password
                self?.performSegue(withIdentifier: "unwindToLogInVC", sender: nil)
            }
        }
    }
    //MARK: - IBAction functions
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        guard let email = email, let password = password, let username = username else { return }
        signUpViewModel.createUser(email: email, password: password, username: username)
    }
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let enteredText = textField.text else { return }
        switch textField {
        case phoneNumberAndEmailTextField:
            if enteredText.contains("@") {
                self.email = enteredText
            } else {
                self.phoneNumber = enteredText
            }
        case usernameTextField:
            self.username = enteredText
        case passwordTextField:
            self.password = enteredText
        case confirmPasswordTextField:
            self.confirmedPassword = enteredText
        default:
            return
        }
    }
}
