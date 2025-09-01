//
//  HomeViewModelProtocol.swift
//  MovieExplorer
//
//  Created by Diab on 01/09/2025.
//

import Foundation

protocol HomeViewModelDelegate{
    func favWasPressed(movieId: Int)
    func didSelectMovie(index: Int)
}


protocol HomeViewModelProtocol:BaseViewModelProtocol,HomeViewModelDelegate {
    var movieDataPublisher: Published<[MovieDTO]>.Publisher { get }
    var movies: [MovieDTO] { get }
    func loadMoreMovies()
    func didLoad()
}
