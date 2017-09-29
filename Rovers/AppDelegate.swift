//
//  AppDelegate.swift
//  Rovers
//
//  Created by Admin on 25/09/2017.
//  Copyright © 2017 pavbox. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let memoryCapacity = 100 * 1024 * 1024
        let diskCapacity = 150 * 1024 * 1024
        let urlcache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "Rovers_Cache")
        
        URLCache.shared = urlcache
        return true
    }
    

    func applicationWillResignActive(_ application: UIApplication) { }

    func applicationDidEnterBackground(_ application: UIApplication) { }

    func applicationWillEnterForeground(_ application: UIApplication) { }

    func applicationDidBecomeActive(_ application: UIApplication) { }

    func applicationWillTerminate(_ application: UIApplication) { }


}

