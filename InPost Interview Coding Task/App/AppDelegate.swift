//
//  AppDelegate.swift
//  InPost Interview Coding Task
//
//  Created by Damian Piwowarski on 03/11/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    private let dependencyProvider: DependencyProvidersContaining
    var window: UIWindow?

    override init() {
        dependencyProvider = DependencyProvidersContainer.shared
        window = UIWindow(frame: UIScreen.main.bounds)

        super.init()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        startAppFlow()

        return true
    }

    // wb_TODO: use Coordinators
    private func startAppFlow() {
        let packListFactory = PackListFactory(dependencyContainer: dependencyProvider.packListDependencyProvider)
        let packListController = packListFactory.makePackListController()

        window?.rootViewController = IPNavigationController(rootViewController: packListController)
        window?.makeKeyAndVisible()
    }
    
}
