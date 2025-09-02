//
//  SceneDelegate.swift
//  MovieExplorer
//
//  Created by Diab on 31/08/2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    let appDIContainer = AppDIContainer()
    var appCoordinator: AppCoordinator?
    static private(set) var current: SceneDelegate?
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        SceneDelegate.current = self
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        guard let window = window else {return}
        appCoordinator = AppCoordinator(window: window, appDIContainer: appDIContainer)
        appCoordinator?.start()
    }

}


