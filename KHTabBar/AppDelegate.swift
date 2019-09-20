//
//  AppDelegate.swift
//  KHTabBar
//
//  Created by kaho on 19/09/2019.
//  Copyright © 2019 kaho. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = DemoViewController()
        window?.makeKeyAndVisible()
        return true
    }

}

