//
//  SceneDelegate.swift
//  RemoteLearn
//
//  Created by Konrad on 21/04/2020.
//  Copyright © 2020 Konrad. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
      if let windowScene = scene as? UIWindowScene {
                let window = UIWindow(windowScene: windowScene)
                window.overrideUserInterfaceStyle = .light
                window.rootViewController = UINavigationController(rootViewController: HomeController())
                UINavigationBar.appearance().shadowImage = UIImage()
                UINavigationBar.appearance().backgroundColor = UIColor(red:0.13, green:0.59, blue:0.95, alpha:1)
                UINavigationBar.appearance().barTintColor = UIColor(red:0.13, green:0.59, blue:0.95, alpha:1)
                UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
                self.window = window
                window.makeKeyAndVisible()
            }
        
        if #available(iOS 13, *)
        {
            let statusBar = UIView(frame: (UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame)!)
            statusBar.backgroundColor = UIColor(red:0.13, green:0.59, blue:0.95, alpha:1)
            UIApplication.shared.keyWindow?.addSubview(statusBar)
        } else {
           // ADD THE STATUS BAR AND SET A CUSTOM COLOR
           let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
           if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
              statusBar.backgroundColor = UIColor(red:0.13, green:0.59, blue:0.95, alpha:1)
           }
           UIApplication.shared.statusBarStyle = .lightContent
        }
        
            guard let _ = (scene as? UIWindowScene) else { return }
        }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

