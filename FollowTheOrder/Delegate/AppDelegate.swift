//
//  AppDelegate.swift
//  FollowTheOrder
//
//  Created by Ann Yesip on 11.01.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if let level = UserDefaults.standard.string(forKey: "level") {
            print("Level \(level)")
        } else {
            UserDefaults.standard.set(1, forKey: "level")
            UserDefaults.standard.set(0, forKey: "bestResult")
        }

        window = UIWindow(frame: UIScreen.main.bounds)
        let homeViewController = GameViewController()
        window?.rootViewController = homeViewController
        window?.makeKeyAndVisible()
        return true
    }

}

