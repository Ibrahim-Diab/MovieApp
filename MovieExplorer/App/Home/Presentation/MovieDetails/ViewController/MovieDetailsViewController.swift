//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Rasslan on 26/08/2025.
//

import UIKit
import Combine

final class MovieDetailsViewController: BaseVC {
    
  @IBOutlet private weak var backgroundImageView: UIImageView!
  @IBOutlet private weak var posterImageView: UIImageView!
  @IBOutlet private weak var nameLabel: UILabel!
  @IBOutlet private weak var ratingLabel: UILabel!
  @IBOutlet private weak var dateLabel: UILabel!
  @IBOutlet private weak var favButton: UIButton!
  @IBOutlet private weak var overviewLabel: UILabel!
  @IBOutlet private weak var votersLabel: UILabel!
  @IBOutlet private weak var languageLabel: UILabel!
  @IBOutlet private weak var infoStack: UIStackView!

    private let viewModel: MovieDetailsViewModelProtocol
    
    init(viewModel: MovieDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: "MovieDetailsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
    
    @IBAction private func addToFavoritesWasPressed(_ sender: Any) {
        viewModel.setItemFavourite()
    }
}

// MARK: - UISetup
private extension MovieDetailsViewController {
    
    private func setupUI(){
        title = "Movie Details"
        infoStack.clipsToBounds = true
        infoStack.layer.cornerRadius = 8.0
    }
    
    private func configuration(){
        setupUI()
        bindViewState()
        bindMovieData()
        viewModel.didLoad()
    }
    
}

// MARK: - Binding
private extension MovieDetailsViewController {
    
    
    func bindMovieData(){
        viewModel.movieDataPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movieData in
                guard let self else {return}
                configureUI(with: movieData)
            }.store(in: &viewModel.cancellables)
    }
        
    private func bindViewState(){
        viewModel.viewState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] viewState in
            guard let self = self else {return}
            switch viewState {
            case .content:
                hideIndicator()
            case .loading:
                showIndicator()
            case .error(message: let message):
                show(errorMessage: message)
            }
        }.store(in: &viewModel.cancellables)
    }

    
    func configureUI(with model: MovieDetailsDataModel) {
        posterImageView.setWith(model.posterURL)
        backgroundImageView.setWith(model.backgroundUrl)
        nameLabel.text = model.title
        ratingLabel.text = model.ratingText
        dateLabel.text = model.releaseDate
        favButton.isSelected = model.isFavorite ?? true
        favButton.tintColor = (model.isFavorite ?? false) ? .red : .white
        overviewLabel.text = model.overview
        languageLabel.text = model.language
        votersLabel.text = model.voters
    }
}
