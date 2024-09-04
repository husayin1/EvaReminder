//
//  SceneDelegate.swift
//  Medicine Reminder
//
//  Created by John Alfy on 8/12/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.rootViewController = UINavigationController(rootViewController: MyMedicationsReminderRouter.createModule())
        window?.makeKeyAndVisible()
    }
}

