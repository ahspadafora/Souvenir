//
//  AuthAPI.swift
//  souvenir
//
//  Created by Amber Spadafora on 5/17/19.
//  Copyright © 2019 Amber Spadafora. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol AuthAPIServiceProtocol {
    func createUserFromEmail(email: String, password: String, completion: @escaping (Bool, Error?, String?) -> Void)
    func signUserInWithEmail(email: String, password: String, completion: @escaping (Bool, Error?) -> Void)
}

class AuthAPIService: AuthAPIServiceProtocol {
    public func createUserFromEmail(email: String, password: String, completion: @escaping (Bool, Error?, String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            error == nil ? completion(true, nil, email) : completion(false, error, nil)
        }
    }
    public func signUserInWithEmail(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (_, error) in
            error == nil ? completion(true, nil): completion(false, error)
        }
    }
}
