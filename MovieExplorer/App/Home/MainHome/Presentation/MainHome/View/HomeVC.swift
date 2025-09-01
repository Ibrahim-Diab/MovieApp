//
//  HomeVC.swift
//  MovieExplorer
//
//  Created by Diab on 1/09/2025.
//

import UIKit

class HomeVC: BaseVC {
    
    // MARK: - IBOutlets -
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Properties -
    
    var viewModel: HomeViewModelProtocol!
    
    // MARK: - Init -
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: "HomeVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
    
}

// MARK: - Configuration -

extension HomeVC {
    
    private func configuration() {
        bindViewState()
        configureCollection()
        configureBinding()
        configureNavigation()
    }
    
    private func configureCollection() {
        collectionView.register(cellType: MovieCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = createCollectionViewLayout()
    }
    
    private func configureNavigation() {
        navigationItem.title = "Enjoy with Films 🤗 "
        navigationController?.navigationBar.prefersLargeTitles = true

    }
    
    func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .absolute(200)
            )
        )
        let layoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(200)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize:layoutSize ,
            repeatingSubitem: item,
            count: 2
        )
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    
    private func configureBinding() {
        viewModel.didLoad()
        viewModel.movieDataPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else { return }
                self.collectionView.reloadData()
            }
            .store(in: &viewModel.cancellables)
        
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
}


// MARK: - UICollectionViewDelegate and DataSource -

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: MovieCollectionViewCell.self, for: indexPath)
        let movie = viewModel.movies[indexPath.row]
        cell.configCell(with:movie)
        cell.favAction = { [weak self] id in
            self?.viewModel.favWasPressed(movieId: id)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //viewModel.didSelectSections(at: indexPath.row)
        show(errorMessage: "Ajmedd")
    }
}

extension HomeVC {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height

        // When the user scrolls close to bottom, load more
        if offsetY > contentHeight - frameHeight * 2 {
            viewModel.loadMoreMovies()
        }
    }
}

