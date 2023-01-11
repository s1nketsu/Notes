//
//  SceneDelegate.swift
//  myNotes
//
//  Created by Полищук Александр on 10.01.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let navigationController = UINavigationController()
        let builder = BuilderImplementation()
        let router = RouterImplementation(navigationController: navigationController, builder: builder)
        router.openInitView()
        window?.rootViewController = navigationController
        window?.overrideUserInterfaceStyle = .light
        window?.makeKeyAndVisible()
    }
}
