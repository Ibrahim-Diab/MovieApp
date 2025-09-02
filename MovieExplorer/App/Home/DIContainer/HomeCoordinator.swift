//
//  HomeCoordinator.swift
//  MovieExplorer
//
//  Created by Diab on 31/08/2025.
//

import UIKit

class HomeCoordinator: HomeCoordinatorProtocol {

    var onCompletion: CompletionBlock?
    var navigationController: UINavigationController
    private let dependencies: HomeCoordinatorDependencies
    var childCoordinators = [Coordinator]()
    
    // MARK: - Life Cycle -
    
    init(navigationController: UINavigationController, dependencies: HomeCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    deinit {
        print("deinit \(Self.self)")
    }
    
    // MARK: - Navigation
    
    
    func start() {
        navigate(to: .homeInit)
    }
    
    func navigate(to step: HomeStep) {
        switch step {
        case .homeInit:
            navigateToHome()
        case let .movieDetails(data,delegate):
            navigateToMovieDetails(data: data,delegate:delegate)
            
        }
    }
    
}

extension HomeCoordinator {
    
    fileprivate func navigateToHome() {
        let controller = dependencies.buildMovieListViewController(coordinator: self)
        navigationController.setViewControllers([controller], animated: true)
        
    }
    
    fileprivate func navigateToMovieDetails(data:MovieDetailsDataModel, delegate:RefreshMovieListProtocol) {
        let controller = dependencies.buildMovieDetailsViewController(data: data, delegate: delegate)
        navigationController.pushViewController(controller, animated: true)
    }
}
