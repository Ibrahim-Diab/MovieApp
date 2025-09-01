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
        print("HomeDIContainer is deinit, No memory leak found")
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
    
    func makeHomeUseCase() -> HomeUseCaseProtocol {
        return HomeUseCase(repository: homeRepository, favouriteRepository: favouriteRepository)
    }
    
}

// MARK: - HomeCoordinatorDependencies -

extension HomeDIContainer: HomeCoordinatorDependencies {
    
    func buildHomeViewController(coordinator: HomeCoordinatorProtocol) -> HomeVC {
        let viewModel = HomeViewModel(useCase: makeHomeUseCase(),
                                      coordinator: coordinator)
        return HomeVC(viewModel: viewModel)
    }
    
}




