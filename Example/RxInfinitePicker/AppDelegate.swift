//
//  AppDelegate.swift
//  RxInfinitePicker
//
//  Created by lm2343635 on 03/15/2019.
//  Copyright (c) 2019 lm2343635. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.rootViewController = ViewController(viewModel: ViewModel())
        window?.makeKeyAndVisible()
        return true
    }

}
