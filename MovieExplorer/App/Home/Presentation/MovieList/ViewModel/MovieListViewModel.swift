//
//  MovieListViewModel.swift
//  MovieExplorer
//
//  Created by Diab on 1/09/2025.
//

import Combine
import Foundation

final class MovieListViewModel: MovieListViewModelProtocol  {
    
    ///MARK: - Properites
    @Published internal var movies: [MovieDTO] = []
    var movieDataPublisher: Published<[MovieDTO]>.Publisher { $movies }
    var cancellables = Set<AnyCancellable>()
    var viewState: PassthroughSubject<ViewState, Never> = .init()
    
    private let useCase: MovieListUseCaseProtocol
    weak var coordinator: HomeCoordinatorProtocol?
    
    private var currentPage = 1
    private var totalPages = 1
    private var isLoading = false
    
    init(useCase: MovieListUseCaseProtocol,coordinator: HomeCoordinatorProtocol) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
    
    func didLoad() {
        fetchMovies(page: 1)
    }
    
    func loadMoreMovies() {
        guard !isLoading, currentPage < totalPages else { return }
        currentPage += 1
        fetchMovies(page: currentPage)
    }
    
    private func fetchMovies(page: Int) {
        isLoading = true
        viewState.send(.loading)
        useCase.getMovieData(page: page)
            .sink { [weak self] completion in
                guard let self else { return }
                self.isLoading = false
                switch completion {
                case .finished:
                    print("✅ Finished loading page \(page)")
                case .failure(let error):
                    print("❌ Error loading movies: \(error.localizedDescription)")
                    viewState.send(.error(message: error.localizedDescription))
                }
            } receiveValue: { [weak self] data in
                guard let self else { return }
                viewState.send(.content)
                self.totalPages = data.totalPages ?? 1
                guard let newMoviews = data.results else {return}
                finishFetchMoview(newMoviews: newMoviews)
            }.store(in: &cancellables)
    }
    
    func favWasPressed(movieId: Int) {
        useCase.updateStorageFavourite(movieId: movieId)
        movies = useCase.makeFavouriteMovie(movieId, movies: movies)
    }
    
    func finishFetchMoview(newMoviews:[MovieDTO]){
        self.movies = useCase.handelMovieData(currentPage, lastMovies: movies, newMovies: newMoviews)
    }
}

//MARK: - Routes -

extension MovieListViewModel{
    func didSelectMovie(index: Int) {
        let movie = useCase.createMovieDetailsData(data: movies[index])
        self.coordinator?.navigate(to: .movieDetails(data: movie, delegate: self))
    }
}

extension MovieListViewModel:RefreshMovieListProtocol{
    func updateItemFavouriteInStorage(with movieID:Int) {
        movies = useCase.makeFavouriteMovie(movieID, movies: movies)
    }
}




