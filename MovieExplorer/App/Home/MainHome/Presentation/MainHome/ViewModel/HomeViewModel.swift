//
//  HomeViewModel.swift
//  MovieExplorer
//
//  Created by Diab on 1/09/2025.
//

import Combine

final class HomeViewModel: HomeViewModelProtocol  {
    
     ///MARK: - Properites
    @Published internal var movies: [MovieDTO] = []
    var movieDataPublisher: Published<[MovieDTO]>.Publisher { $movies }
    var cancellables = Set<AnyCancellable>()
    var viewState: PassthroughSubject<ViewState, Never> = .init()
    
    private let useCase: HomeUseCaseProtocol
    weak var coordinator: HomeCoordinatorProtocol?
    
    private var currentPage = 1
    private var totalPages = 1
    private var isLoading = false
    
    init(useCase: HomeUseCaseProtocol,coordinator: HomeCoordinatorProtocol) {
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
        movies = useCase.makeFavouriteMovie(movieId, movies: movies)
    }
    
    func finishFetchMoview(newMoviews:[MovieDTO]){
        self.movies = useCase.handelMovieData(currentPage, lastMovies: movies, newMovies: newMoviews)
    }
}

 //MARK: - Routes -
extension HomeViewModel{
    
    func didSelectMovie(index: Int) {
        print("")
    }
}
