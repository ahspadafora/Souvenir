//
//  SignUpViewController.swift
//  souvenir
//
//  Created by Amber Spadafora on 5/16/19.
//  Copyright © 2019 Amber Spadafora. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    // TO DO: TURN INTO USER MODEL
    var email: String?
    var password: String?
    var confirmedPassword: String?
    lazy var signUpViewModel: SignUpViewModel = {
        return SignUpViewModel()
    }()
    var alertView: UIAlertController = UIAlertController()
    // MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViewModel()
        addTapGestureForKeyboardDismissal()
    }
    
    private func initializeViewModel() {
        signUpViewModel.createdEmailAccountClosure = { [weak self] (email, password, error) in
            if error != nil {
                guard let errorMessage = error?.localizedDescription else { return }
                self?.displayAlertView(with: errorMessage, alertView: self?.alertView)
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
        guard let email = email, let password = password else {
            displayAlertView(with: "Please complete all required fields", alertView: alertView)
            return
        }
        signUpViewModel.createUser(email: email, password: password)
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
        case emailTextField:
           email = enteredText
        case passwordTextField:
            password = enteredText
        case confirmPasswordTextField:
            confirmedPassword = enteredText
        default:
            return
        }
    }
}
