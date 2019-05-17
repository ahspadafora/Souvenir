//
//  LoginViewModel.swift
//  souvenir
//
//  Created by Amber Spadafora on 5/16/19.
//  Copyright © 2019 Amber Spadafora. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol AuthAPIServiceProtocol {
    func createUserFromEmail(email: String, password: String, username: String, completion: @escaping (Bool, Error?, String?) -> Void)
    func signUserInWithEmail(email: String, password: String, completion: @escaping (Bool, Error?) -> Void)
}

class AuthAPIService: AuthAPIServiceProtocol {
    public func createUserFromEmail(email: String, password: String, username: String, completion: @escaping (Bool, Error?, String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            // TO DO: Add username table & add confirm new username is unique, if so add it to table [UID: Username]
            error == nil ? completion(true, nil, email) : completion(false, error, nil)
        }
    }
    public func signUserInWithEmail(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (_, error) in
            error == nil ? completion(true, nil): completion(false, error)
        }
    }
}

final class LogInViewModel {
    var emailString: String?
    var error: Error?
    private var isLoggedIn: Bool = false {
        didSet {
            self.updateLoginStatusClosure?(emailString, error)
        }
    }

    var updateLoginStatusClosure: ((String?, Error?) -> Void)?
    let authAPIService: AuthAPIServiceProtocol
    init(authAPIService: AuthAPIServiceProtocol = AuthAPIService()) {
        self.authAPIService = authAPIService
    }
    func logInUser(email: String, password: String) {
        self.authAPIService.signUserInWithEmail(email: email, password: password) { (success, error) in
            self.emailString = email
            self.error = error
            self.isLoggedIn = success
        }
    }
}
