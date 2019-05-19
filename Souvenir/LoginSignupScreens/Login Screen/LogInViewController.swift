//
//  ViewController.swift
//  souvenir
//
//  Created by Amber Spadafora on 5/8/19.
//  Copyright © 2019 Amber Spadafora. All rights reserved.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {
    // MARK: - Properties
    var email: String?
    var password: String?
    lazy var logInViewModel: LogInViewModel = {
        return LogInViewModel()
    }()
    var alertView: UIAlertController = UIAlertController()
    // MARK: - IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    // MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViewModel()
        addTapGestureForKeyboardDismissal()
    }
    // binding of loginViewModel to loginViewController
    private func initializeViewModel() {
        logInViewModel.updateLoginStatusClosure = { [weak self] (error) in
            if error != nil {
                guard let errorMessage = error?.localizedDescription else { return }
                self?.displayAlertView(with: errorMessage, alertView: self?.alertView)
            } else {
                self?.performSegue(withIdentifier: "userLoggedInSegue", sender: nil)
            }
        }
    }
    // MARK: - IBAction Functions
    @IBAction func logginButtonTapped(_ sender: UIButton) {
        if let email = email, let password = password {
            logInViewModel.logInUser(email: email, password: password)
        }
    }
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToSignUpVC", sender: nil)
    }
    // MARK: - Navigation Methods
    @IBAction func unwindToLogInVC(_ unwindSegue: UIStoryboardSegue) {
        guard let segueIdentifer = unwindSegue.identifier else { return }
        switch segueIdentifer {
        case "unwindToLogInVCFromSignUp":
            let sourceViewController = unwindSegue.source as? SignUpViewController
            guard let email = sourceViewController?.email, let password = sourceViewController?.password else { return }
            logInViewModel.logInUser(email: email, password: password)
        case "unwindToLogInVCFromLogout":
            
            return
        default:
            return
        }
    }

}

extension LogInViewController: UITextFieldDelegate {
    // MARK: - Textfield Delegate Methods
    // only happens when textField is unselected
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let enteredText = textField.text else { return }
        switch textField {
        case emailTextField:
            self.email = enteredText
        case passwordTextField:
            self.password = enteredText
        default: return
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
