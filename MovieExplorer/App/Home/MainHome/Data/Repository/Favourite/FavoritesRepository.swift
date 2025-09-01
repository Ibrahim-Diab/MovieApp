//
//  FavoritesRepository.swift
//  MovieExplorer
//
//  Created by Diab on 01/09/2025.
//


import Foundation

final class FavoritesRepository: FavoritesRepositoryProtocol {
    
    private let favoritesKey = "favorite_movie_ids"
    private var favorites: Set<Int> = []
    
    init() {
        loadFavorites()
    }
    
    func isFavorite(id: Int) -> Bool {
        favorites.contains(id)
    }
    
    func toggleFavorite(id: Int) {
        if favorites.contains(id) {
            favorites.remove(id)
        } else {
            favorites.insert(id)
        }
        saveFavorites()
    }
    
    func allFavorites() -> Set<Int> {
        favorites
    }
    
    // MARK: - Persistence
    private func loadFavorites() {
        if let stored = UserDefaults.standard.array(forKey: favoritesKey) as? [Int] {
            favorites = Set(stored)
        }
    }
    
    private func saveFavorites() {
        UserDefaults.standard.set(Array(favorites), forKey: favoritesKey)
    }
}
