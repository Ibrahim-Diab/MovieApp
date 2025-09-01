//
//  HomeUseCase.swift
//  MovieExplorer
//
//  Created by Diab on 31/08/2025.
//

import Combine

protocol HomeUseCaseProtocol {
    func getMovieData(page:Int) -> AnyPublisher<MovieApiResponse, NetworkError>
    func makeFavouriteMovie(_ movieId:Int, movies:[MovieDTO]) -> [MovieDTO]
    func handelMovieData(_ page: Int, lastMovies: [MovieDTO], newMovies: [MovieDTO]) -> [MovieDTO]
}

final class HomeUseCase: HomeUseCaseProtocol {
    
    private let repository: HomeRepositoryProtocol
    private let favouriteRepository: FavoritesRepositoryProtocol
    
    init(repository: HomeRepositoryProtocol,
         favouriteRepository: FavoritesRepositoryProtocol) {
        self.repository = repository
        self.favouriteRepository = favouriteRepository
    }
    
    func getMovieData(page:Int) -> AnyPublisher<MovieApiResponse, NetworkError> {
        repository.getMovieData(page: page)
    }
    
    func makeFavouriteMovie(_ movieId: Int, movies: [MovieDTO]) -> [MovieDTO] {
        var updatedMovies = movies
        if let index = updatedMovies.firstIndex(where: { $0.id == movieId }) {
            updatedMovies[index].isFavourite.toggle()
            favouriteRepository.toggleFavorite(id: movieId)
        }
        return updatedMovies
    }
    
    func handelMovieData(_ page: Int,
                         lastMovies: [MovieDTO],
                         newMovies: [MovieDTO]) -> [MovieDTO] {
        
        let merged = (page == 1 ? newMovies : lastMovies + newMovies)
        let favs = favouriteRepository.allFavorites()
        
        return merged.compactMap { movie in
            var movieItem = movie
            movieItem.isFavourite = favs.contains(movie.id)
            return movieItem
        }
    }
}
