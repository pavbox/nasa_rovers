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
        // Override point for customization after application launch.
        // let urlcache = URLCache(memoryCapacity: 4 * 1024 * 1024, diskCapacity: 20 * 1024 * 1024, diskPath: nil)
        // URLCache.setSharedURLCache(urlcache)
        // let cage = URLCache()
        
//        print("cached")
//        print(URLCache.shared)
//        URLCache.shared = URLCache(memoryCapacity: 4 * 1024 * 1024, diskCapacity: 20 * 1024 * 1024, diskPath: nil)
//        print("!")
//        print(URLCache.shared)
//
        
//        let memoryCapacity = 100 * 1024 * 1024
//        let diskCapacity = 100 * 1024 * 1024
//        let urlcache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "pavbox_disk1")
//        
//        CachedURLResponse()
       
        // URLCache.shared = urlcache
        // URLCache.storeCachedResponse(urlcache)
//        URLCache.StoragePolicy = ""
        // NSURLCache.
        
//        let memoryCapacity = 100 * 1024 * 1024
//        let diskCapacity = 100 * 1024 * 1024
//        let urlcache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "pavbox_disk1")
//        sleep(1)
        return true
    }
    

    func applicationWillResignActive(_ application: UIApplication) { }

    func applicationDidEnterBackground(_ application: UIApplication) { }

    func applicationWillEnterForeground(_ application: UIApplication) { }

    func applicationDidBecomeActive(_ application: UIApplication) { }

    func applicationWillTerminate(_ application: UIApplication) { }


}

