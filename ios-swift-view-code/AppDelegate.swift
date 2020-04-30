//
//  AppDelegate.swift
//  ios-swift-view-code
//
//  Created by Danilo Pena on 28/04/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)

        let chars = UIViewController()
        chars.view.backgroundColor = .red
        
        window.rootViewController = chars
        window.makeKeyAndVisible()
        
        return true
    }
}

