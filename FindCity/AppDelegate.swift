//
//  AppDelegate.swift
//  FindCity
//
//  Created by Jafar on 15/02/2022.
//
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let cityViewController = CityViewController.getViewController()
        let citiesViewModel = CitiesViewModel()
        cityViewController.bindViewModel(viewModel: citiesViewModel)
        let rootVC = UINavigationController(rootViewController: cityViewController)
        rootVC.navigationBar.prefersLargeTitles = true

        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        return true
    }
}
