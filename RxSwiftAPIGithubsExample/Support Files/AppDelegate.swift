//
//  AppDelegate.swift
//  RxSwiftAPIGithubsExample
//
//  Created by Nguyễn Trọng Anh Tuấn on 14/07/2019.
//  Copyright © 2019 Cock Developer. All rights reserved.
//

import UIKit
import SwiftyBeaver

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // setting log
        // add log destinations. at least one is needed!
        let console = ConsoleDestination()  // log to Xcode Console

        // use custom format and set console output to short time, log level & message
//        console.format = "$DHH:mm:ss$d $L $M"
        // or use this for JSON output: console.format = "$J"

        // add the destinations to SwiftyBeaver
        logger.addDestination(console)
        logger.enter()
        // Override point for customization after application launch.
        logger.exit("true")
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        logger.enter()
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        logger.exit()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        logger.enter()
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        logger.exit()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        logger.enter()
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        logger.exit()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        logger.enter()
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        logger.exit()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        logger.enter()
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        logger.exit()
    }

}
