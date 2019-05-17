//
//  LoginViewModel.swift
//  souvenir
//
//  Created by Amber Spadafora on 5/16/19.
//  Copyright © 2019 Amber Spadafora. All rights reserved.
//

import Foundation

final class LogInViewModel {
    var error: Error?
    private var isLoggedIn: Bool = false {
        didSet {
            self.updateLoginStatusClosure?(error)
        }
    }

    var updateLoginStatusClosure: ((Error?) -> Void)?
    let authAPIService: AuthAPIServiceProtocol
    init(authAPIService: AuthAPIServiceProtocol = AuthAPIService()) {
        self.authAPIService = authAPIService
    }
    func logInUser(email: String, password: String) {
        self.authAPIService.signUserInWithEmail(email: email, password: password) { (success, error) in
            self.error = error
            self.isLoggedIn = success
        }
    }
}
