//
//  MovieDetailsUseCase.swift
//  MovieExplorer
//
//  Created by Diab on 02/09/2025.
//

import Combine

final class MovieDetailsUseCase: MovieDetailsUseCaseProtocol {
    
    private let favouriteRepository: FavoritesRepositoryProtocol
    
    init(favouriteRepository: FavoritesRepositoryProtocol) {
        self.favouriteRepository = favouriteRepository
    }
    
    func setItemFavourite(_ movieId: Int) -> Bool {
        favouriteRepository.toggleFavorite(id: movieId)
        return favouriteRepository.isFavorite(id: movieId)
    }

}
