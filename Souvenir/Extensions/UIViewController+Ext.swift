//
//  UIViewController+Ext.swift
//  souvenir
//
//  Created by Amber Spadafora on 5/17/19.
//  Copyright © 2019 Amber Spadafora. All rights reserved.
//

import UIKit

extension UIViewController {
    func displayAlertView(with message: String, alertView: UIAlertController?) {
        guard let alertView = alertView else { return }
        alertView.message = message
        alertView.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil))
        self.present(alertView, animated: true)
    }
    func addTapGestureForKeyboardDismissal() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
