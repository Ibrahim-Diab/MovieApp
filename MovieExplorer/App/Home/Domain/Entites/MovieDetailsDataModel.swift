//
//  MovieDetailsDataModel.swift
//  MovieExplorer
//
//  Created by Diab on 01/09/2025.
//

import Foundation

struct MovieDetailsDataModel: Equatable {
    var id: Int?
    var posterURL: String?
    var backgroundUrl: String?
    var title: String?
    var ratingText: String?
    var releaseDate: String?
    var isFavorite: Bool?
    var overview: String?
    var language: String?
    var voters: String?
}
