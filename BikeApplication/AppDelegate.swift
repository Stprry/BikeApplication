//
//  AppDelegate.swift
//  BikeApplication
//
//  Created by Sam Perry on 17/02/2020.
//  Copyright © 2020 Sam Perry. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

 var window: UIWindow?
    let barButtonAppereance = UIBarButtonItem.appearance()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        let locationManager = LocationManager.shared
        locationManager.requestWhenInUseAuthorization()

      //  let backButton = UIImage(named: "back")// declare image
       // let backButtonImage = backButton?.stretchableImage(withLeftCapWidth: 0, topCapHeight: 10)// modify image
      //  barButtonAppereance.setBackButtonBackgroundImage(backButtonImage, for: .normal, barMetrics: .default)// change button appearance
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        CoreDataStack.saveContext()
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
        CoreDataStack.saveContext()
    }


}

