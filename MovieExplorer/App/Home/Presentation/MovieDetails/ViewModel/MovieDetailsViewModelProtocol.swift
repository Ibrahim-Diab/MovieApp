//
//  MovieDetailsViewModelProtocol.swift
//  MovieApp
//
//  Created by Rasslan on 26/08/2025.
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

