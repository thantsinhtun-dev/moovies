//
//  HomeViewModel.swift
//  Moovies
//
//  Created by Thant Sin Htun on 12/06/2023.
//
import SwiftUI
import Combine


class HomeViewModel : ObservableObject {
    @Published var nowPlayingDataSource : MovieResponseVO?
    @Published var nowPlayingList : [MovieVO] = []
    @Published var popularMovieList : [MovieVO] = []
    @Published var genreList : [GenreVO] = []
    
    private let theMovieFetcher : TheMovieFetcher
    
    
    private var disposables = Set<AnyCancellable>()
    
    init(theMovieFetcher:TheMovieFetcher){
        self.theMovieFetcher = theMovieFetcher
    }
    
    func loadGetNowPlaying(page:Int?) {
        theMovieFetcher
            .getNowShowing(forPage: page)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { value in
                
                switch value {
                case .failure:
                    self.nowPlayingDataSource = nil
                case .finished:
                    break
                }
                
            }, receiveValue: { data in
                
                print("data",data.results.count)
                self.nowPlayingDataSource = data
                self.nowPlayingList = data.results
                
            })
            .store(in: &disposables)
    }
    
    func loadPopularMovies(page:Int?){
        theMovieFetcher
            .getPopularMovies(forPage: page)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { value in
                
                switch value {
                case .failure(let error):
                    print("error",error)
                    self.popularMovieList = []
                case .finished:
                    break
                }
            }, receiveValue: { data in
                print("data popularMovieList ",data.results.count)
                self.popularMovieList = data.results
            })
            .store(in: &disposables)
    }
    
    func loadGenreList(){
        theMovieFetcher
            .getGenreList()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { value in
                switch value {
                case .failure(let error):
                    print("error",error)
                    self.genreList = []
                case .finished:
                    break
                }
            }, receiveValue: { data in
                self.genreList = data.genres
            })
            .store(in: &disposables)
    }
    
    
    
}


extension HomeViewModel {
    func  movieDetailView(showDetail:Binding<Bool>,forMovieId movieId:String,fetcher:TheMovieFetcher) -> some View {
        return HomeViewBuilder.makeMovieDetailView(showDetail: showDetail, forMovieId: movieId, theMovieFetcher: fetcher)
    }
}
