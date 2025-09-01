//
//  BaseViewModel.swift
//  MovieExplorer
//
//  Created by Diab on 01/09/2025.
//

import Combine


protocol BaseViewModelProtocol: AnyObject {
    var cancellables: Set<AnyCancellable> { get set }
    var viewState:PassthroughSubject<ViewState, Never> {get set}
}
