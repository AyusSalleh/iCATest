//
//  SceneDelegateExtension.swift
//  iCATest
//
//  Created by Ayus Salleh on 15/03/2023.
//

import UIKit

extension SceneDelegate {
    
    func initializeVC() {
        let controller = UINavigationController(rootViewController: HomeViewController())
        animateWindow(viewController: controller)
    }
    
    func animateWindow(viewController: UIViewController) {
        if let window = window {
            window.rootViewController = viewController
            window.makeKeyAndVisible()

            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        } else {
            window = UIWindow(windowScene: windowScene)
            window?.backgroundColor = UIColor.clear
            window?.rootViewController = viewController
            window?.makeKeyAndVisible()
        }
        
        // Refer https://medium.com/@kalyan.parise/understanding-scene-delegate-app-delegate-7503d48c5445
    }
}
