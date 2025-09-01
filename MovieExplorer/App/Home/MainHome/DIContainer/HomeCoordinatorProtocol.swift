//
//  HomeCoordinatorProtocol.swift
//  MovieExplorer
//
//  Created by Diab on 31/08/2025.
//

import UIKit

protocol HomeCoordinatorProtocol: NavigationCoordinator {
    func navigate(to step: HomeStep)
}


// MARK: - Coordinator Dependencies
protocol HomeCoordinatorDependencies {
    func buildHomeViewController(coordinator: HomeCoordinatorProtocol) -> HomeVC
}


// MARK: - Steps -
public enum HomeStep: Step {
    case homeInit
}
