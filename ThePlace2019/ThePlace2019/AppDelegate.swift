//
//  AppDelegate.swift
//  ThePlace2019
//
//  Created by Михаил Луцкий on 26.10.2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import UIKit
import GooglePlaces
import Firebase
import MagicalRecord

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey("AIzaSyDxyMUp-nPA6C5M7lFydWSyHwCDAM5zYYE")
        GMSPlacesClient.provideAPIKey("AIzaSyDxyMUp-nPA6C5M7lFydWSyHwCDAM5zYYE")
        FirebaseApp.configure()
        
        MagicalRecord.setupCoreDataStack()
        MagicalRecord.setLoggingLevel(.off)
        
        let story = UIStoryboard(name: "Main", bundle: nil)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = story.instantiateInitialViewController()
        self.window?.makeKeyAndVisible()
        // Override point for customization after application launch.
        return true
    }

//    // MARK: UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }


}

