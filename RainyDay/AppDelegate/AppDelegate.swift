//
//  AppDelegate.swift
//  RainyDay
//
//  Created by Mthokozisi Malaza on 2023/10/03.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
//    static let bgAppTaskId = "your.background.task.identifier"
//    var bgTask: BGAppRefreshTask?
//    lazy var bgExpirationHandler = {{
//        if let task = self.bgTask {
//            task.setTaskCompleted(success: true)
//        }
//    }}()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let weatherView = ForecastRouter.setupModule()
        let navigationController = UINavigationController(rootViewController: weatherView)
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        return true
    }

//    func applicationDidEnterBackground(_ application: UIApplication) {
//        scheduleFirebasePostTask(minutes: 10) // We can set our intial request to anything we want.
//    }
    
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}

    
}
