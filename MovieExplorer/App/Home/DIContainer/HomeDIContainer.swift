//
//  HomeDIContainer.swift
//  MovieExplorer
//
//  Created by Diab on 31/08/2025.
//

import UIKit

class HomeDIContainer {

    struct Dependencies {
        let apiDataTransferService: NetworkExecutor
    }
    
    let dependencies: Dependencies
    
    // MARK: - Init -
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Deinit -
    
    deinit {
        print("\(Self.self) is deinit, No memory leak found")
    }
    
    // MARK: - Module Coordinator -
    
    func buildHomeCoordinator(in navigationController: UINavigationController) -> HomeCoordinatorProtocol {
        let coordinator = HomeCoordinator(navigationController: navigationController, dependencies: self)
        return coordinator
    }
    
    // MARK: - apiDataTransferService -
    private lazy var apiDataTransferService: NetworkServiceProtocol = {
        return NetworkService(executor: dependencies.apiDataTransferService)
    }()
    
    
    
    // MARK: - Repository -
    
    private lazy var homeRepository: HomeRepositoryProtocol = {
        return HomeRepository(networkService: apiDataTransferService)
    }()
    
    private lazy var favouriteRepository: FavoritesRepositoryProtocol = {
        return FavoritesRepository()
    }()
        
        
    // MARK: - UseCase -
    
    func makeMovieListUseCase() -> MovieListUseCaseProtocol {
        return MovieListUseCase(repository: homeRepository, favouriteRepository: favouriteRepository)
    }
    
    func makeMovieDetailsUseCase() -> MovieDetailsUseCaseProtocol {
        return MovieDetailsUseCase(favouriteRepository: favouriteRepository)
    }
    
}

// MARK: - HomeCoordinatorDependencies -

extension HomeDIContainer: HomeCoordinatorDependencies {
    
    func buildMovieListViewController(coordinator: HomeCoordinatorProtocol) -> MovieListViewController {
        let viewModel = MovieListViewModel(useCase: makeMovieListUseCase(),
                                      coordinator: coordinator)
        let vc = MovieListViewController(viewModel: viewModel)
        return vc
    }
    
    func buildMovieDetailsViewController(data:MovieDetailsDataModel) -> MovieDetailsViewController {
        let viewModel = MovieDetailsViewModel(useCase: makeMovieDetailsUseCase(), movieData: data)
        let vc = MovieDetailsViewController(viewModel: viewModel)
        return vc
    }
    
}




