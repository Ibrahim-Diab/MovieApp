//
//  MovieCellViewModel.swift
//  MovieExplorer
//
//  Created by Diab on 1/09/2025.
//

import  Foundation

protocol MovieCellDataSource {
    var id: Int { get }
    var title: String?{ get }
    var posterURL: String { get }
    var isMovieFavourite: Bool { get set }
}

