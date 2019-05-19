//
//  AppDelegate.swift
//  souvenir
//
//  Created by Amber Spadafora on 5/8/19.
//  Copyright © 2019 Amber Spadafora. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        return true
    }

}
