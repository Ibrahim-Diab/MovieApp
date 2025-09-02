//
//  GeneralViewState.swift
//  MovieExplorer
//
//  Created by Diab on 01/09/2025.
//

// MARK: - View State
enum ViewState: Equatable {
    case content
    case loading
    case error(message: String)
    case showMessage(message: String)
}
