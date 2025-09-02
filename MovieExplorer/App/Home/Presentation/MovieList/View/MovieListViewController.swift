//
//  MovieListViewController.swift
//  MovieExplorer
//
//  Created by Diab on 1/09/2025.
//

import UIKit

class MovieListViewController: BaseVC {
    
    // MARK: - IBOutlets -
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Properties -
    
    var viewModel: MovieListViewModelProtocol!
    
    // MARK: - Init -
    
    init(viewModel: MovieListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: "MovieListViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
}

extension MovieListViewController{
    
    func setupUI(){
        configureNavigation()
        configureCollection()
        
    }
    
    private func configureNavigation() {
        title = "Enjoy with Films 🤗 "
    }
    
    private func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
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
            layoutSize: layoutSize,
            subitem: item,
            count: 2
        )
        
        
        
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func configureCollection() {
        collectionView.register(cellType: MovieCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = createCollectionViewLayout()
    }
    
}


// MARK: - Configuration -


extension MovieListViewController {
    
    private func configuration() {
        bindViewState()
        configureBinding()
        setupUI()
        viewModel.didLoad()
    }
        
    private func configureBinding() {
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
            case let .showMessage(message):
                show(successMessage: message)
            }
        }.store(in: &viewModel.cancellables)
    }
}


// MARK: - UICollectionView DataSource -

extension MovieListViewController: UICollectionViewDataSource {
    
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
    
}

// MARK: - UICollectionView Delegate -

extension MovieListViewController:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectMovie(index: indexPath.row)
    }
    
}

extension MovieListViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height

        if offsetY > contentHeight - frameHeight * 2 {
            viewModel.loadMoreMovies()
        }
    }
}

