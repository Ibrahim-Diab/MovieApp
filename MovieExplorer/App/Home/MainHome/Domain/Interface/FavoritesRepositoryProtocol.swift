//
//  FavoritesRepositoryProtocol.swift
//  MovieExplorer
//
//  Created by Diab on 01/09/2025.
//

import Foundation

protocol FavoritesRepositoryProtocol {
    func isFavorite(id: Int) -> Bool
    func toggleFavorite(id: Int)
    func allFavorites() -> Set<Int>
}
