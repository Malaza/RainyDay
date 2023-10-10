//
//  AppDelegate.swift
//  RainyDay
//
//  Created by Mthokozisi Malaza on 2023/10/03.
//

import UIKit
import BackgroundTasks

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        BGTaskScheduler.shared.register ( forTaskWithIdentifier: Constants.fetchNotificationName, using: nil) { (task) in
            self.appRefreshTask(task: task as! BGAppRefreshTask)
        }
        
        let weatherView = ForecastRouter.setupModule()
        let navigationController = UINavigationController(rootViewController: weatherView)
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
    
    
    //MARK: - Helper methods
    func appRefreshTask(task: BGAppRefreshTask) {
        
        task.expirationHandler = {
            task.setTaskCompleted(success: false)
        }
        NotificationCenter.default.post(name: NSNotification.Name(Constants.completedNotificationName),
                                        object: self, userInfo: nil)
        scheduleBackgroundFetch()
    }
    
    func scheduleBackgroundFetch() {
        
        let forecastFetchTask = BGAppRefreshTaskRequest(identifier: Constants.fetchNotificationName)
        forecastFetchTask.earliestBeginDate = Date(timeIntervalSinceNow: 3600)
        
        do {
            try BGTaskScheduler.shared.submit(forecastFetchTask)
        }
        catch {
            print("Fetch failed: \(error.localizedDescription)")
        }
    }
    
    
    //MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
    
    
}
