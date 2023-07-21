//
//  AppDelegate.swift
//  DemoTimer
//
//  Created by Hector Climaco on 07/07/23.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let vc = HomeTimerViewController()
        let navController = UINavigationController(rootViewController: vc)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        IQKeyboardManager.shared.enable = true
        
        return true
    }

}

