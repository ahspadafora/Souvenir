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
    // MARK:-Properties
    var email: String?
    var password: String?
    var phoneNumber: String?
    lazy var logInViewModel: LogInViewModel = {
        return LogInViewModel()
    }()
    // MARK:- IBOutlets
    @IBOutlet weak var phoneNumberAndEmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    // MARK:- View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViewModel()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    // binding of loginViewModel to loginViewController
    private func initializeViewModel() {
            // updateLoginStatusClosure
        logInViewModel.updateLoginStatusClosure = { [weak self] (loggedInEmail, error) in
            if loggedInEmail != nil {
                // present pop-up with success message then segue to feed
                self?.performSegue(withIdentifier: "userLoggedInSegue", sender: nil)
            }
            if error != nil {
                // present pop-up with error message then prompt user to try again
                print(error?.localizedDescription)
            }
        }
            // createdAccountClosure
//        logInViewModel.createdAccountClosure = { [weak self] in
//            // do something when createdAccountClosure is called
//        }
    }
    //MARK:- IBAction Functions
    @IBAction func logginButtonTapped(_ sender: UIButton) {
        if let email = email, let password = password {
            logInViewModel.logInUser(email: email, password: password)
        }
    }
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToSignUpVC", sender: nil)
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "goToSignUpVC" {
//            let destinationVC =
//        }
//    }

    @IBAction func unwindToLogInVC(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source as? SignUpViewController
        // Use data from the view controller which initiated the unwind segue
        guard let username = sourceViewController?.username, let email = sourceViewController?.email, let password = sourceViewController?.password else { return }
        logInViewModel.logInUser(email: email, password: password)
    }

}

extension LogInViewController: UITextFieldDelegate {
    // only happens when textField is unselected
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.text)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let enteredText = textField.text else { return false }
        switch textField {
        case phoneNumberAndEmailTextField:
            if enteredText.contains("@") {
               self.email = enteredText
            } else {
                self.phoneNumber = enteredText
            }
        case passwordTextField:
            self.password = enteredText
        default: return false
        }
        textField.resignFirstResponder()
        return true
    }
}
