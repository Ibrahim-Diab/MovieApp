//
//  MovieListViewModelProtocol.swift
//  MovieExplorer
//
//  Created by Diab on 01/09/2025.
//

import Foundation

protocol FavouriteDelegate{
    func favWasPressed(movieId: Int)
}

protocol MovieListViewModelDelegate:FavouriteDelegate{
    func didSelectMovie(index: Int)
}

protocol MovieListViewModelProtocol:BaseViewModelProtocol,MovieListViewModelDelegate {
    var movieDataPublisher: Published<[MovieDTO]>.Publisher { get }
    var movies: [MovieDTO] { get }
    func loadMoreMovies()
    func didLoad()
}
