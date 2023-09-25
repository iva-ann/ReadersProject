//
//  AppDelegate.swift
//  TestProject
//
//  Created by RX Group on 23.09.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    fileprivate lazy var coordinator: Coordinatable = self.makeCoordinator()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        coordinator.start()
        return true
    }
}

private extension AppDelegate {
    func makeCoordinator() -> Coordinatable {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        let rootNavigation = UINavigationController()
        window?.rootViewController = rootNavigation
        window?.makeKeyAndVisible()

        return AppCoordinator(factory: CoordinatorFactory(),
                              router: Router(rootController: rootNavigation))
    }
}
