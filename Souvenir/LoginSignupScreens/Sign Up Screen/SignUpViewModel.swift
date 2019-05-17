//
//  SignUpViewModel.swift
//  souvenir
//
//  Created by Amber Spadafora on 5/16/19.
//  Copyright © 2019 Amber Spadafora. All rights reserved.
//

import Foundation
import FirebaseAuth

final class SignUpViewModel {
    var email: String?
    var password: String?
    var error: Error?
    var createdEmailAccountClosure: ((_ email: String?, _ password: String?, _ error: Error?) -> Void)?
    private var createdAccount: Bool = false {
        didSet {
            self.createdEmailAccountClosure?(email, password, error)
        }
    }
    let authAPIService: AuthAPIServiceProtocol
    init(authAPIService: AuthAPIServiceProtocol = AuthAPIService()) {
        self.authAPIService = authAPIService
    }
    func createUser(email: String, password: String) {
        authAPIService.createUserFromEmail(email: email, password: password) { (success, error, email) in
            self.email = email
            self.password = password
            self.error = error
            self.createdAccount = success
        }
    }
}
