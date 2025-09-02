//
//  MovieDetailsViewModel.swift
//  MovieApp
//
//  Created by Rasslan on 26/08/2025.
//

import Combine

final class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    
    var cancellables = Set<AnyCancellable>()
    var viewState: PassthroughSubject<ViewState, Never> = .init()
    var movieDataPublisher: PassthroughSubject<MovieDetailsDataModel, Never> = .init()
    var movieData = MovieDetailsDataModel()
    private let useCase: MovieDetailsUseCaseProtocol
    
    
    init(useCase: MovieDetailsUseCaseProtocol,movieData:MovieDetailsDataModel) {
        self.useCase = useCase
        self.movieData = movieData
    }
    
    func didLoad(){
        movieDataPublisher.send(movieData)
    }
    
    func setItemFavourite() {
        guard let movieID = movieData.id else {return}
        let favouriteMovieStatue = useCase.setItemFavourite(movieID)
        movieData.isFavorite = favouriteMovieStatue
        movieDataPublisher.send(movieData)
    }
    
}

