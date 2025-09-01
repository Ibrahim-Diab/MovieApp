//
//  HomeRepositoryProtocol.swift
//  MovieExplorer
//
//  Created by Diab on 31/08/2025.
//

import Combine

protocol HomeRepositoryProtocol {
    func getMovieData(page:Int) -> AnyPublisher<MovieApiResponse, NetworkError>
}

