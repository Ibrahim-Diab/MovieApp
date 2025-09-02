//
//  MovieListUseCase.swift
//  MovieExplorer
//
//  Created by Diab on 31/08/2025.
//

import Combine


final class MovieListUseCase: MovieListUseCaseProtocol {
       
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
        }
        return updatedMovies
    }
    
    func updateStorageFavourite(movieId: Int)  {
        favouriteRepository.toggleFavorite(id: movieId)
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
    
    func createMovieDetailsData(data: MovieDTO) -> MovieDetailsDataModel {
        let movie:MovieDetailsDataModel = .init(
            id: data.id ,
            posterURL:data.posterPath.asImageBaseURLString() ,
            backgroundUrl:data.backdropPath.asImageBaseURLString() ,
            title: data.title,
            ratingText: String(format: "%.1f/10", data.voteAverage ?? 0 ),
            releaseDate: data.releaseDate,
            isFavorite: data.isFavourite,
            overview: data.overview,
            language: data.originalLanguage,
            voters: "\(data.voteCount  ?? 0) voters"
        )
        return movie
    }
}
