//
//  SouvenirTabBarController.swift
//  souvenir
//
//  Created by Amber Spadafora on 5/17/19.
//  Copyright © 2019 Amber Spadafora. All rights reserved.
//

import UIKit

class SouvenirTabBarController: UITabBarController {

    lazy var viewModel: LogInViewModel = {
        return LogInViewModel()
    }()
    let alertView: UIAlertController = UIAlertController()
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViewModel()
    }
    func initializeViewModel() {
        viewModel.updateLoginStatusClosure = { [weak self] (error) in
            print("Update login status closure called")
            if let errorMessage = error?.localizedDescription {
                self?.displayAlertView(with: errorMessage, alertView: self?.alertView)
            } else {
                self?.performSegue(withIdentifier: "unwindToLogInVCFromLogout", sender: nil)
            }
        }
    }
    @IBAction func signOutButtonTapped(_ sender: UIBarButtonItem) {
        viewModel.logOutUser()
    }
}
