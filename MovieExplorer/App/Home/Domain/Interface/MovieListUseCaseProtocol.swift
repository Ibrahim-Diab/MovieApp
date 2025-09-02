//
//  MovieListUseCaseProtocol.swift
//  MovieExplorer
//
//  Created by Diab on 02/09/2025.
//

import Combine

protocol MovieListUseCaseProtocol {
    func getMovieData(page:Int) -> AnyPublisher<MovieApiResponse, NetworkError>
    func makeFavouriteMovie(_ movieId:Int, movies:[MovieDTO]) -> [MovieDTO]
    func handelMovieData(_ page: Int, lastMovies: [MovieDTO], newMovies: [MovieDTO]) -> [MovieDTO]
    func createMovieDetailsData(data:MovieDTO) -> MovieDetailsDataModel
}
