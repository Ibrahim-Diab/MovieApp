//
//  MovieDetailsViewModelProtocol.swift
//  MovieExplorer
//
//  Created by Diab on 01/09/2025.
//

import Foundation
import Combine

protocol MovieDetailsDelegate{
    func setItemFavourite()
}

protocol MovieDetailsViewModelProtocol:BaseViewModelProtocol,MovieDetailsDelegate{
    func didLoad()
    var movieDataPublisher:PassthroughSubject<MovieDetailsDataModel, Never> {get set}
}

