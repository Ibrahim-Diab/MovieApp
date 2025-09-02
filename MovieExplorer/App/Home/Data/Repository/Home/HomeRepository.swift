//
//  HomeRepository.swift
//  MovieExplorer
//
//  Created by Diab on 31/08/2025.
//

import Combine

final class HomeRepository: HomeRepositoryProtocol {
   
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    deinit {
        print("\(Self.self) is deinit, No memory leak found")
    }
    
    func getMovieData(page:Int) -> AnyPublisher<MovieApiResponse, NetworkError> {
        let endpoint = HomeEndPoint.getMovieDataAPIComponent(page: page)
        return networkService.request(endpoint, progress: nil)
    }
    
    
}
