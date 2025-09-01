//
//  AppCoordinator.swift
//  MovieExplorer
//
//  Created by Diab on 31/08/2025.
//

import UIKit

public class AppCoordinator: Coordinator {
    
    public var onCompletion: CompletionBlock?
    
    private let window: UIWindow
    private let appDIContainer: AppDIContainer
    
    // MARK: - Initializer -
    
    public init(window: UIWindow,
                appDIContainer: AppDIContainer) {
        self.window = window
        self.appDIContainer = appDIContainer
    }
    
    public func start(){
        navigateToHomeFlow()
    }

    fileprivate func navigateToHomeFlow() {
        let navigation = UINavigationController()
        let module = appDIContainer.buildHomeModule()
        let coordinator = module.buildHomeCoordinator(in: navigation)
        coordinator.onCompletion = { [unowned self, unowned coordinator] in
            removeDependency(coordinator)
        }
        self.window.rootViewController = navigation
        self.window.makeKeyAndVisible()
        addDependency(coordinator)
        coordinator.start()
    }
    
}

