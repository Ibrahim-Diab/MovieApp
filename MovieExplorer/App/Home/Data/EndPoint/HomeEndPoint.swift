//
//  HomeEndPoint.swift
//  MovieExplorer
//
//  Created by Diab on 31/08/2025.
//

import Foundation

struct HomeEndPoint {
    private init() {}
}

extension HomeEndPoint {
    
    static func getMovieDataAPIComponent(page: Int) -> ConfigEndpoint<MovieApiResponse> {
        return .init(
            path: "3/discover/movie",
            method: .get,
            parameters: [
                "page": page
            ]
        )
    }

}
