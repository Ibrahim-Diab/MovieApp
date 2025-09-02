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
    func buildMovieListViewController(coordinator: HomeCoordinatorProtocol) -> MovieListViewController
    func buildMovieDetailsViewController(data:MovieDetailsDataModel,delegate:RefreshMovieListProtocol) -> MovieDetailsViewController
}


// MARK: - Steps -
 enum HomeStep: Step {
     case homeInit
     case movieDetails(data:MovieDetailsDataModel,delegate:RefreshMovieListProtocol)
}



