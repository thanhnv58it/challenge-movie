//
//  AppDelegate.swift
//  Movie
//
//  Created by Thành Ngô Văn on 04/12/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let movie = MovieListViewController(nibName: MovieListViewController.nibName, bundle: nil)
        self.window?.rootViewController = UINavigationController(rootViewController: movie)
        self.window?.overrideUserInterfaceStyle = .dark
        self.window?.makeKeyAndVisible()
        return true
    }
    
    
}

