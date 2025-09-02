//
//  RefreshMovieListProtocol.swift
//  MovieExplorer
//
//  Created by Diab on 02/09/2025.
//

import Foundation

protocol RefreshMovieListProtocol:AnyObject{
    func updateItemFavouriteInStorage(with movieID:Int)
}
