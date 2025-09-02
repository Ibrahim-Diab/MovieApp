//
//  MovieDetailsViewModel.swift
//  MovieExplorer
//
//  Created by Diab on 01/09/2025.
//

import Combine

final class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    
    var cancellables = Set<AnyCancellable>()
    var viewState: PassthroughSubject<ViewState, Never> = .init()
    var movieDataPublisher: PassthroughSubject<MovieDetailsDataModel, Never> = .init()
    var movieData = MovieDetailsDataModel()
    
    private let useCase: MovieDetailsUseCaseProtocol
    weak var movieListDelegate:RefreshMovieListProtocol?
    
    init(useCase: MovieDetailsUseCaseProtocol,movieData:MovieDetailsDataModel, movieListDelegate:RefreshMovieListProtocol? = nil) {
        self.useCase = useCase
        self.movieData = movieData
        self.movieListDelegate = movieListDelegate
    }
    
    func didLoad(){
        movieDataPublisher.send(movieData)
    }
    
    func setItemFavourite() {
        guard let movieID = movieData.id else {return}
        let favouriteMovieStatue = useCase.setItemFavourite(movieID)
        movieData.isFavorite = favouriteMovieStatue
        movieDataPublisher.send(movieData)
        movieListDelegate?.updateItemFavouriteInStorage(with: movieID)
        viewState.send(.showMessage(message: (movieData.isFavorite ?? false) ? "item added to favourite" : "item removed from favourite"  ))
    }
    
}

